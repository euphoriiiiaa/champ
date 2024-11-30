import 'dart:async';
import 'dart:developer' as logs;
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:champ/api/supabase.dart';
import 'package:champ/data/data.dart';
import 'package:champ/models/adsmodel.dart';
import 'package:champ/models/categorymodel.dart';
import 'package:champ/models/detailmodel.dart';
import 'package:champ/models/favoritemodel.dart';
import 'package:champ/models/notificationmodel.dart';
import 'package:champ/models/ordermodel.dart';
import 'package:champ/models/ordersneakersmodel.dart';
import 'package:champ/models/popularsneaker.dart';
import 'package:champ/models/sneakercartmodel.dart';
import 'package:champ/models/sneakermodel.dart';
import 'package:champ/presentation/pages/drawerscreen.dart';
import 'package:champ/presentation/pages/mainpageview.dart';
import 'package:champ/presentation/pages/otppage.dart';
import 'package:champ/presentation/pages/profilepage.dart';
import 'package:champ/presentation/pages/signin.dart';
import 'package:champ/presentation/widgets/emailnotification.dart';
import 'package:champ/presentation/widgets/writepassword.dart';
import 'package:champ/riverpod/addressprovider.dart';
import 'package:champ/riverpod/cartprovider.dart';
import 'package:champ/riverpod/notificationsprovider.dart';
import 'package:email_validator_flutter/email_validator_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/yandex.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:uuid/uuid.dart';

class Func {
  Future<List<CategoryModel>> getCategories() async {
    try {
      var sup = GetIt.I.get<SupabaseClient>();

      var list = await sup.from('categories').select();

      List<CategoryModel> newList =
          (list as List).map((item) => CategoryModel.fromMap(item)).toList();

      return newList;
    } catch (e) {
      logs.log(e.toString());
      return List.empty();
    }
  }

  void exitFromApp() async {
    if (Supabase.instance.client.auth.currentUser != null) {
      var sup = GetIt.I.get<SupabaseClient>();
      await sup.auth.signOut();
      Future.delayed(const Duration(milliseconds: 500), exit(0));
    }
  }

  double getCartSum(WidgetRef ref) {
    var cart = ref.read(cartProvider);
    double sum = 0;
    cart.forEach((key, value) {
      sum += value.price * value.count!;
    });

    return sum;
  }

  Future<User?> changeUserInfo(String name, String surname, String address,
      String phoneNumber, BuildContext context) async {
    if ((name.isEmpty &&
            surname.isEmpty &&
            address.isEmpty &&
            phoneNumber.isEmpty) ||
        (name.isEmpty ||
            surname.isEmpty ||
            address.isEmpty ||
            phoneNumber.isEmpty)) {
      logs.log('fields is empty');
      return null;
    }

    try {
      var sup = GetIt.I.get<SupabaseClient>();

      var updatedUser = await sup.auth.updateUser(UserAttributes(data: {
        'name': name,
        'surname': surname,
        'address': address,
        'phoneNumber': phoneNumber
      }));
      logs.log(
          'success data changed for user ${sup.auth.currentUser!.userMetadata!['name']}');
      Navigator.pop(context, {
        'name': name,
        'surname': surname,
        'address': address,
        'number': phoneNumber
      });
    } catch (e) {
      logs.log(e.toString());
    }
  }

  Future<void> markAsReaded(
      NotificationModel notification, WidgetRef ref) async {
    try {
      var sup = GetIt.I.get<SupabaseClient>();

      await sup!
          .from('notifications')
          .update({'readed': true}).eq('id', notification.id);

      logs.log('notification updated');
      ref.read(notificationsProvider.notifier).state = true;
    } catch (e) {
      logs.log(e.toString());
    }
  }

  Future<void> startReadTimer(
      NotificationModel notification, WidgetRef ref) async {
    await Future.delayed(
      const Duration(seconds: 1),
      () => markAsReaded(notification, ref),
    );
  }

  Future<List<NotificationModel>> getNotifications() async {
    try {
      var sup = GetIt.I.get<SupabaseClient>();

      var list = await sup!.from('notifications').select();

      List<NotificationModel> newList = (list as List)
          .map((item) => NotificationModel.fromMap(item))
          .toList();

      newList.sort((a, b) => a.id.compareTo(b.id));
      return newList;
    } catch (e) {
      logs.log(e.toString());
      return List.empty();
    }
  }

  Future<SneakerCartModel?> getSneakerToCart(
      String id, Uint8List imageFuture) async {
    try {
      var sup = GetIt.I.get<SupabaseClient>();

      var list = await sup!.from('sneakers').select().eq('id', id);

      SneakerModel sneaker =
          list.map((item) => SneakerModel.fromMap(item)).first;

      SneakerCartModel sneakerr = SneakerCartModel(
        id: sneaker.id,
        image: imageFuture,
        name: sneaker.name,
        price: sneaker.price,
        count: 1,
      );
      return sneakerr;
    } catch (e) {
      logs.log(e.toString());
      return null;
    }
  }

  Future<List<SneakerModel>> getSneakers() async {
    try {
      var sup = GetIt.I.get<SupabaseClient>();

      var list = await sup.from('sneakers').select();

      List<SneakerModel> newList =
          (list as List).map((item) => SneakerModel.fromMap(item)).toList();

      return newList;
    } catch (e) {
      logs.log(e.toString());
      return List.empty();
    }
  }

  Future<List<DetailModel>> getSneakersForDetail() async {
    try {
      var sup = GetIt.I.get<SupabaseClient>();

      var list = await sup.from('sneakers').select();

      List<SneakerModel> newList =
          (list as List).map((item) => SneakerModel.fromMap(item)).toList();
      List<DetailModel> images = [];
      for (var item in newList) {
        final Uint8List file =
            await sup.storage.from('assets').download('${item.id}.png');
        var detail = DetailModel(sneakerid: item.id, image: file);
        images.add(detail);
      }

      return images;
    } catch (e) {
      logs.log(e.toString());
      return List.empty();
    }
  }

  Future<bool?> checkIfSneakerFavorite(String sneakerId) async {
    try {
      var sup = GetIt.I.get<SupabaseClient>();

      var list = await sup.from('favorites').select().eq('sneaker', sneakerId);
      if (list.isEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      logs.log(e.toString());
      return null;
    }
  }

  Future<void> unselectFavorite(String sneakerId) async {
    try {
      var sup = GetIt.I.get<SupabaseClient>();

      await sup.from('favorites').delete().eq('sneaker', sneakerId);
      logs.log('success delete favorite sneaker');
    } catch (e) {
      logs.log(e.toString());
    }
  }

  Future<void> selectFavorite(String sneakerId) async {
    try {
      var sup = GetIt.I.get<SupabaseClient>();

      await sup
          .from('favorites')
          .insert({'sneaker': sneakerId, 'user': sup.auth.currentUser!.id});
      logs.log('success insert favorite sneaker');
    } catch (e) {
      logs.log(e.toString());
    }
  }

  Future<List<SneakerModel>> getFavoriteSneakers() async {
    try {
      var sup = GetIt.I.get<SupabaseClient>();
      if (sup.auth.currentUser != null) {
        var user = sup.auth.currentUser;
        var list = await sup.from('favorites').select().eq('user', user!.id);
        var sneakers = await sup.from('sneakers').select();
        List<SneakerModel> newList = [];
        for (var item in list) {
          for (var item2 in sneakers) {
            if (item['sneaker'] == item2['id']) {
              var sneaker = SneakerModel.fromMap(item2);
              newList.add(sneaker);
            }
          }
        }
        return newList;
      } else {
        return List.empty();
      }
    } catch (e) {
      logs.log(e.toString());
      return List.empty();
    }
  }

  Future<List<SneakerModel>> getSneakersForCategories(
      String nameCategory) async {
    try {
      var sup = GetIt.I.get<SupabaseClient>();
      var categoriesmodel = await sup.from('categories').select();
      var categorieslist = (categoriesmodel as List)
          .map((item) => CategoryModel.fromMap(item))
          .toList();
      var category =
          categorieslist.firstWhere((item) => item.name == nameCategory);
      var list =
          await sup.from('sneakers').select().eq('category', category.id);

      List<SneakerModel> newList =
          (list as List).map((item) => SneakerModel.fromMap(item)).toList();

      return newList;
    } catch (e) {
      logs.log(e.toString());
      return List.empty();
    }
  }

  void clearServerCart() async {
    try {
      var sup = Supabase.instance.client;

      await sup
          .from('cart')
          .delete()
          .eq('user', Supabase.instance.client.auth.currentUser!.id);
      logs.log('success cleared server cart');
    } catch (e) {
      logs.log(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    try {
      var sup = Supabase.instance.client;

      var ordermodel = await sup
          .from('order')
          .select()
          .eq('user', Supabase.instance.client.auth.currentUser!.id);
      var orders =
          (ordermodel as List).map((item) => OrderModel.fromMap(item)).toList();
      orders.sort((a, b) => b.created_at.compareTo(a.created_at));
      List<Map<String, dynamic>> list = [];
      for (var item in orders) {
        list.add({
          'id': item.id,
          'created_at': item.created_at,
          'user': item.user,
          'sum': item.sum,
          'address': item.address
        });
      }

      logs.log('success list of orders');
      return list;
    } catch (e) {
      logs.log('asdasd ' + e.toString());
      return [{}];
    }
  }

  Future<List<OrderSneakersModel>> getOrderSneakers(int id) async {
    try {
      var sup = Supabase.instance.client;
      logs.log(id.toString());
      var ordersneakermodel =
          await sup.from('orderSneakers').select().eq('orderid', id);
      var ordersneakerlist = (ordersneakermodel as List)
          .map((item) => OrderSneakersModel.fromMap(item))
          .toList();
      List<OrderSneakersModel> newList = [];
      for (var item in ordersneakerlist) {
        logs.log(item.toString());
        var sneakersmodel =
            await sup.from('sneakers').select().eq('id', item.sneaker);
        var sneakerr = sneakersmodel.first;
        var image = await getSneakerImage(item.sneaker);
        OrderSneakersModel sneaker = OrderSneakersModel(
            id: item.id,
            sneaker: item.sneaker,
            orderid: item.orderid,
            count: item.count,
            cost: (sneakerr['price'] as num).toDouble(),
            sneakername: sneakerr['name'],
            image: image);
        newList.add(sneaker);
      }
      return newList;
    } catch (e) {
      logs.log('errpr: ' + e.toString());
      return List.empty();
    }
  }

  Future<bool> createOrder(WidgetRef ref) async {
    try {
      var supabase = GetIt.I.get<SupabaseClient>();
      final cart = ref.watch(cartProvider);
      final cartNotifier = ref.read(cartProvider.notifier);
      final address = ref.watch(addressProvider);
      final total = ref.watch(cartTotalProvider);
      var user = Supabase.instance.client.auth.currentUser;
      if (user != null) {
        var orderList = await supabase.from('order').select();

        var list = (orderList as List)
            .map((item) => OrderModel.fromMap(item))
            .toList();
        var id = list.length + 1;

        await supabase.from('order').insert({
          'id': id,
          'created_at': DateTime.timestamp().toString(),
          'user': user.id,
          'sum': total,
          'address': address
        });

        var uuid = Uuid();
        for (var item in cart.keys) {
          await supabase.from('orderSneakers').insert({
            'id': uuid.v4(),
            'sneaker': cart[item]!.id,
            'orderid': id,
            'count': cart[item]!.count,
          });
        }
        logs.log('successfuly created order');
        cartNotifier.clearCart();
        clearServerCart();
        return true;
      }
      return false;
    } catch (e) {
      logs.log(e.toString());
      return false;
    }
  }

  Future<Position> getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions is denied');
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions is denied forever, we cant anything');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<List<SneakerModel>> getSneakersForCategoriesSecond(
      String nameCategory) async {
    try {
      var sup = GetIt.I.get<SupabaseClient>();
      var categoriesmodel = await sup.from('categories').select();
      var categorieslist = (categoriesmodel as List)
          .map((item) => CategoryModel.fromMap(item))
          .toList();
      var category =
          categorieslist.firstWhere((item) => item.name == nameCategory);
      var list =
          await sup.from('sneakers').select().eq('category', category.id);

      List<SneakerModel> newList =
          (list as List).map((item) => SneakerModel.fromMap(item)).toList();

      return newList;
    } catch (e) {
      logs.log(e.toString());
      return List.empty();
    }
  }

  Future<List<SneakerModel>> getPopularSneakers() async {
    try {
      var sup = GetIt.I.get<SupabaseClient>();

      var list = await sup!.from('popular').select();

      List<PopularSneaker> popular =
          (list as List).map((item) => PopularSneaker.fromMap(item)).toList();

      List<SneakerModel> newList = [];
      for (var item in popular) {
        var sneakerModel =
            await sup.from('sneakers').select().eq('id', item.sneaker);
        SneakerModel sneaker =
            sneakerModel.map((item) => SneakerModel.fromMap(item)).first;

        newList.add(sneaker);
      }

      return newList;
    } catch (e) {
      logs.log(e.toString());
      return List.empty();
    }
  }

  Future<List<AdsModel>> getAds() async {
    try {
      var sup = GetIt.I.get<SupabaseClient>();

      var list = await sup!.from('ads').select();

      List<AdsModel> newList =
          (list as List).map((item) => AdsModel.fromMap(item)).toList();

      return newList;
    } catch (e) {
      logs.log(e.toString());
      return List.empty();
    }
  }

  Future<Uint8List?> getAdImage(String uuid) async {
    try {
      var sup = GetIt.I.get<SupabaseClient>();

      final Uint8List file =
          await sup!.storage.from('ads').download('$uuid.png');

      return file;
    } catch (e) {
      return null;
    }
  }

  Future<List<SneakerModel>> getSneakersSort(String nameSneaker) async {
    try {
      var sup = GetIt.I.get<SupabaseClient>();

      var list = await sup!.from('sneakers').select().eq('name', nameSneaker);

      List<SneakerModel> newList =
          (list as List).map((item) => SneakerModel.fromMap(item)).toList();

      return newList;
    } catch (e) {
      logs.log(e.toString());
      return List.empty();
    }
  }

  Future<Uint8List?> getSneakerImage(String uuid) async {
    try {
      var sup = GetIt.I.get<SupabaseClient>();

      final Uint8List file =
          await sup!.storage.from('assets').download('$uuid.png');

      return file;
    } catch (e) {
      return null;
    }
  }

  Future<List<Uint8List>?> getAllSneakersImages() async {
    try {
      var sup = GetIt.I.get<SupabaseClient>();

      List<Uint8List> images = [];
      var sneakers = await sup.from('sneakers').select();
      var list =
          (sneakers as List).map((item) => SneakerModel.fromMap(item)).toList();
      for (var item in list) {
        final Uint8List file =
            await sup.storage.from('assets').download('${item.id}.png');
        images.add(file);
      }

      return images;
    } catch (e) {
      return null;
    }
  }

  void launchPdf(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => Center(
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                height: MediaQuery.of(context).size.height - 150,
                width: MediaQuery.of(context).size.width - 80,
                child: SfPdfViewer.asset('assets/laba.pdf'),
              ),
            ));
  }

  void tryToRegUser(
      String email, String password, String name, BuildContext context) async {
    if ((email.isEmpty && password.isEmpty && name.isEmpty) ||
        (email.isEmpty || password.isEmpty || name.isEmpty)) {
      logs.log('field is empty');
      return;
    }

    if (Data.isChecked == false) {
      logs.log('checkbox isnt checked');
      return;
    }

    if (EmailValidatorFlutter().validateEmail(email) == false) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Электронная почта не корректная"),
      ));
      return;
    }

    if (!email.contains('@') || !email.contains('.')) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Электронная почта не корректная"),
      ));

      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Пароль должен содержать не менее 6 символов"),
      ));
      return;
    }

    email.toLowerCase();

    var sup = GetIt.I.get<SupabaseClient>();

    final AuthResponse res = await sup!.auth.signUp(
      email: email,
      password: password,
    );

    if (res.user != null) {
      logs.log('succes reg ${res.user!.email}');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Успешная регистрация"),
      ));
    }

    Navigator.pop(context);
  }

  String getRandomOtp() {
    List<String> otps = ['F64GVB', '776GVH', '22HKV6'];
    var selectedOtp = otps[Random().nextInt(2)];
    logs.log(selectedOtp);
    Data.otpCode = selectedOtp;
    return selectedOtp;
  }

  void sendAnotherMessage(BuildContext context) async {
    String smtpPassword = 'fwalnycwxjsfwtid';
    String smtpEmail = 'remm1e@yandex.ru';
    Data.otpCode = getRandomOtp();

    final smtpServer = yandex(smtpEmail, smtpPassword);

    final message = Message()
      ..from = Address(smtpEmail)
      ..recipients.add(Data.emailUser)
      ..subject = 'OTP Code'
      ..text = 'Your OTP Code: ${Data.otpCode}';

    Data.message = message;
    try {
      final sendReport = await send(message, smtpServer);
      logs.log(sendReport.toString());
    } catch (e) {
      logs.log(e.toString());
    }
  }

  void tryToResetPassword(String emailUser, BuildContext context) async {
    if (emailUser.isEmpty) {
      logs.log('empty fields');
      return;
    }

    String smtpPassword = 'fwalnycwxjsfwtid';
    String smtpEmail = 'remm1e@yandex.ru';
    showCupertinoModalPopup(
      barrierDismissible: false,
      context: context,
      builder: (context) => GestureDetector(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const OtpPage(),
            ),
          );
        },
        child: emailNotification(context),
      ),
    );
    Data.otpCode = getRandomOtp();

    final smtpServer = yandex(smtpEmail, smtpPassword);

    final message = Message()
      ..from = Address(smtpEmail)
      ..recipients.add(emailUser)
      ..subject = 'OTP Code'
      ..text = 'Your OTP Code: ${Data.otpCode}';

    Data.message = message;
    Data.emailUser = emailUser;
    try {
      final sendReport = await send(message, smtpServer);
      logs.log(sendReport.toString());
    } catch (e) {
      logs.log(e.toString());
    }
  }

  Future<void> saveHistoryList(List<String> list) async {
    logs.log('Saving history list: $list');
    var asd = list.join(',');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('myList', asd);
  }

  Future<List<String>> loadHistoryList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? list = prefs.getString('myList');
    logs.log('Loaded history list: $list');
    return list!.split(',');
  }

  void setPassword(BuildContext context) async {
    if (Data.genPassword == null) {
      logs.log('gen password is empty');
      return;
    }
    try {
      var sup = GetIt.I.get<SupabaseClient>();

      final AuthResponse userSign = await sup!.auth.signInWithPassword(
        email: Data.emailUser,
        password: 'dgdfdfd',
      );
      if (userSign.user != null) {
        logs.log('change pass');
      } else {
        logs.log('no user');
      }

      final UserResponse res = await sup.auth.updateUser(
          UserAttributes(email: Data.emailUser, password: Data.genPassword));
      if (res.user != null) {
        logs.log('success changed');
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, CupertinoPageRoute(builder: (context) => const SignIn()));
      }
    } catch (e) {
      logs.log(e.toString());
    }
  }

  void successOtp(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => WritePassword(
        onTap: () => Func().setPassword(context),
      ),
    );
  }

  String genNewPassword(String phrase) {
    var genPass = '';
    for (var i = 0; 6 >= i; i++) {
      genPass = genPass + phrase[Random().nextInt(phrase.length - 1)];
    }

    logs.log(genPass);
    Data.genPassword = genPass;
    return genPass;
  }

  void getUserMeta() async {
    logs.log(
        Supabase.instance.client.auth.currentUser!.userMetadata.toString());
  }

  void tryToSignIn(String email, String password, BuildContext context) async {
    if ((email.isEmpty && password.isEmpty) ||
        (email.isEmpty || password.isEmpty)) {
      logs.log('empty fields');
      return;
    }

    try {
      var sup = GetIt.I.get<SupabaseClient>();

      final AuthResponse res = await sup!.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (res.user != null) {
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => const DrawerScreen()));
        getUserMeta();
      } else {
        logs.log('no user');
      }
    } catch (e) {
      logs.log(e.toString());
    }
  }
}
