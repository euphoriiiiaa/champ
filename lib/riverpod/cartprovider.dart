import 'dart:developer';

import 'package:champ/functions/func.dart';
import 'package:champ/models/cartsupmodel.dart';
import 'package:champ/models/ordersneakersmodel.dart';
import 'package:champ/models/sneakercartmodel.dart';
import 'package:champ/models/sneakermodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final cartSumProvider = StateProvider<double>((ref) => 0.0);
final cartDeliveryProvider = StateProvider<double>((ref) => 0.0);
final cartTotalProvider = StateProvider<double>((ref) => 0.0);

final cartProvider =
    StateNotifierProvider<CartNotifier, Map<String, SneakerCartModel>>((ref) {
  return CartNotifier(ref);
});

class CartNotifier extends StateNotifier<Map<String, SneakerCartModel>> {
  final Ref ref;
  CartNotifier(this.ref) : super({});

  void clearCart() {
    state.clear();
  }

  void repeatCart(int idorder) async {
    try {
      var sup = Supabase.instance.client;

      var cartlist =
          await sup.from('orderSneakers').select().eq('orderid', idorder);
      var sneakerslist = await Func().getSneakers();

      var list = (cartlist as List)
          .map((item) => OrderSneakersModel.fromMap(item))
          .toList();
      for (var item in list) {
        var firstsneaker =
            sneakerslist.firstWhere((item) => item.id == item.id);
        var image = await Func().getSneakerImage(item.id);
        SneakerCartModel sneaker = SneakerCartModel(
            id: item.sneaker,
            count: item.count,
            image: image,
            name: item.sneaker,
            price: firstsneaker.price);
        addToCart(sneaker);
      }
      Future.delayed(const Duration(seconds: 1), () => loadCart());
    } catch (e) {
      log(e.toString());
    }
  }

  void addToCart(SneakerCartModel sneaker) async {
    try {
      state.putIfAbsent(sneaker.id, () => sneaker);
      var sup = Supabase.instance.client;
      log(Supabase.instance.client.auth.currentUser!.id);
      var list = await sup.from('cart').select();
      var cartlist =
          (list as List).map((item) => CartSupModel.fromMap(item)).toList();
      var id = cartlist.length + 1;
      await sup.from('cart').insert({
        'id': id,
        'sneaker': sneaker.id,
        'count': sneaker.count,
        'user': Supabase.instance.client.auth.currentUser!.id
      });
      log('sneaker added to sup cart');
    } catch (e) {
      log(e.toString());
    }
  }

  void loadCart() async {
    try {
      var sup = Supabase.instance.client;
      var list = await sup
          .from('cart')
          .select()
          .eq('user', Supabase.instance.client.auth.currentUser!.id);
      var secondlist = await sup.from('sneakers').select();
      var sneakerslist = (secondlist as List)
          .map((item) => SneakerModel.fromMap(item))
          .toList();
      var cartlist =
          (list as List).map((item) => CartSupModel.fromMap(item)).toList();
      state.clear();
      for (var item in cartlist) {
        for (var item2 in sneakerslist) {
          if (item.sneaker == item2.id) {
            var image = await Func().getSneakerImage(item2.id);
            var sneakercartmodel = SneakerCartModel(
                id: item2.id,
                image: image,
                name: item2.name,
                price: item2.price,
                count: item.count);
            state.putIfAbsent(item.sneaker, () => sneakercartmodel);
          }
        }
      }
      log('success loaded cart from sup');
    } catch (e) {
      log(e.toString());
    }
  }

  bool checkIfAlreadyInCart(String id) {
    if (state.containsKey(id)) {
      return true;
    } else {
      return false;
    }
  }

  void updateCount(String id, int newCount) async {
    try {
      if (state.containsKey(id)) {
        state = Map.from(state);
        state[id] = state[id]!.copyWith(count: newCount);
        updateCartSum();

        var sup = Supabase.instance.client;
        var list = await sup
            .from('cart')
            .select()
            .eq('user', Supabase.instance.client.auth.currentUser!.id);
        var cartlist =
            (list as List).map((item) => CartSupModel.fromMap(item)).toList();
        var sneaker = cartlist.firstWhere((item) => item.sneaker == id);
        await sup
            .from('cart')
            .update({'count': newCount}).eq('sneaker', sneaker.sneaker);
        log('update count sneaker in sup');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  void updateCartSum() {
    double sum = 0;
    state.forEach((key, value) {
      sum += value.price * value.count!;
    });
    ref.read(cartSumProvider.notifier).state = sum;
    ref.read(cartDeliveryProvider.notifier).state = sum / 100;
    ref.read(cartTotalProvider.notifier).state =
        ref.watch(cartSumProvider.notifier).state +
            ref.watch(cartDeliveryProvider.notifier).state;
  }

  void removeFromCart(String id) async {
    try {
      state = Map.from(state);
      state.remove(id);
      updateCartSum();

      var sup = Supabase.instance.client;
      var list = await sup
          .from('cart')
          .select()
          .eq('user', Supabase.instance.client.auth.currentUser!.id);
      var cartlist =
          (list as List).map((item) => CartSupModel.fromMap(item)).toList();
      var sneaker = cartlist.firstWhere((item) => item.sneaker == id);
      await sup.from('cart').delete().eq('sneaker', sneaker.sneaker);
      log('success remove sneaker from cart sup');
    } catch (e) {
      log(e.toString());
    }
  }

  void clearAllSums() {
    ref.read(cartSumProvider.notifier).state = 0;
    ref.read(cartDeliveryProvider.notifier).state = 0;
    ref.read(cartTotalProvider.notifier).state = 0;
  }
}
