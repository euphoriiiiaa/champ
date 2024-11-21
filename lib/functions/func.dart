import 'dart:async';
import 'dart:developer' as logs;
import 'dart:math';
import 'dart:typed_data';

import 'package:champ/api/supabase.dart';
import 'package:champ/data/data.dart';
import 'package:champ/models/adsmodel.dart';
import 'package:champ/models/categorymodel.dart';
import 'package:champ/models/notificationmodel.dart';
import 'package:champ/models/popularsneaker.dart';
import 'package:champ/models/sneakermodel.dart';
import 'package:champ/presentation/pages/mainpageview.dart';
import 'package:champ/presentation/pages/otppage.dart';
import 'package:champ/presentation/pages/signin.dart';
import 'package:champ/presentation/widgets/emailnotification.dart';
import 'package:champ/presentation/widgets/writepassword.dart';
import 'package:champ/riverpod/notificationsprovider.dart';
import 'package:email_validator_flutter/email_validator_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/yandex.dart';
import 'package:native_shared_preferences/native_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Func {
  Future<List<CategoryModel>> getCategories() async {
    try {
      var sup = SupabaseInit().supabase;

      var list = await sup!.from('categories').select();

      List<CategoryModel> newList =
          (list as List).map((item) => CategoryModel.fromMap(item)).toList();

      return newList;
    } catch (e) {
      logs.log(e.toString());
      return List.empty();
    }
  }

  Future<void> markAsReaded(
      NotificationModel notification, WidgetRef ref) async {
    try {
      var sup = SupabaseInit().supabase;

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
      var sup = SupabaseInit().supabase;

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

  Future<List<SneakerModel>> getSneakers() async {
    try {
      var sup = SupabaseInit().supabase;

      var list = await sup!.from('sneakers').select();

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
      var sup = SupabaseInit().supabase;

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
      var sup = SupabaseInit().supabase;

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
      var sup = SupabaseInit().supabase;

      final Uint8List file =
          await sup!.storage.from('ads').download('$uuid.png');

      return file;
    } catch (e) {
      return null;
    }
  }

  Future<List<SneakerModel>> getSneakersSort(String nameSneaker) async {
    try {
      var sup = SupabaseInit().supabase;

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
      var sup = SupabaseInit().supabase;

      final Uint8List file =
          await sup!.storage.from('assets').download('$uuid.png');

      return file;
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

    var sup = SupabaseInit().supabase;

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
    NativeSharedPreferences prefs = await NativeSharedPreferences.getInstance();
    await prefs.setString('myList', asd);
  }

  Future<List<String>> loadHistoryList() async {
    NativeSharedPreferences prefs = await NativeSharedPreferences.getInstance();
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
      var sup = SupabaseInit().supabase;

      final AuthResponse userSign = await sup!.auth.signInWithPassword(
        email: Data.emailUser,
        password: 'dddaaqa',
      );
      if (userSign.user != null) {
        Data.uuidUser = userSign.user!.id;
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

  void tryToSignIn(String email, String password, BuildContext context) async {
    if ((email.isEmpty && password.isEmpty) ||
        (email.isEmpty || password.isEmpty)) {
      logs.log('empty fields');
      return;
    }

    try {
      var sup = SupabaseInit().supabase;

      final AuthResponse res = await sup!.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (res.user != null) {
        Data.uuidUser = res.user!.id;
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => const MainPageView()));
      } else {
        logs.log('no user');
      }
    } catch (e) {
      logs.log(e.toString());
    }
  }
}
