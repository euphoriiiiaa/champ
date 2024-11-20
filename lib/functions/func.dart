import 'dart:developer' as logs;
import 'dart:math';
import 'dart:typed_data';

import 'package:champ/api/supabase.dart';
import 'package:champ/data/data.dart';
import 'package:champ/models/categorymodel.dart';
import 'package:champ/models/notificationmodel.dart';
import 'package:champ/models/sneakermodel.dart';
import 'package:champ/presentation/pages/mainpageview.dart';
import 'package:champ/presentation/pages/otppage.dart';
import 'package:champ/presentation/widgets/emailnotification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
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

  Future<List<NotificationModel>> getNotifications() async {
    try {
      var sup = SupabaseInit().supabase;

      var list = await sup!.from('notifications').select();

      List<NotificationModel> newList = (list as List)
          .map((item) => NotificationModel.fromMap(item))
          .toList();

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

  void tryToResetPassword(String emailUser, BuildContext context) async {
    if (emailUser.isEmpty) {
      logs.log('empty fields');
      return;
    }

    String otp = getRandomOtp();

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
    Data.otpCode = otp;

    final smtpServer = yandex(smtpEmail, smtpPassword);

    final message = Message()
      ..from = Address(smtpEmail)
      ..recipients.add(emailUser)
      ..subject = 'OTP Code'
      ..text = 'Your OTP Code: $otp';

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
