import 'dart:developer';

import 'package:champ/models/sneakercartmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  void addToCart(SneakerCartModel sneaker) {
    state.putIfAbsent(sneaker.id, () => sneaker);
  }

  bool checkIfAlreadyInCart(String id) {
    if (state.containsKey(id)) {
      return true;
    } else {
      return false;
    }
  }

  void updateCount(String id, int newCount) {
    if (state.containsKey(id)) {
      state = Map.from(state);
      state[id] = state[id]!.copyWith(count: newCount);
      updateCartSum();
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

  void removeFromCart(String id) {
    state = Map.from(state);
    state.remove(id);
    updateCartSum();
  }

  void clearAllSums() {
    ref.read(cartSumProvider.notifier).state = 0;
    ref.read(cartDeliveryProvider.notifier).state = 0;
    ref.read(cartTotalProvider.notifier).state = 0;
  }
}
