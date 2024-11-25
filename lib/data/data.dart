import 'package:flutter/widgets.dart';
import 'package:mailer/mailer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Data {
  static String? otpCode;
  static bool isChecked = false;
  static Message? message;
  static String? emailUser;
  static String? genPassword;
  static BuildContext? myContext;
}
