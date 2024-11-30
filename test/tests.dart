import 'package:champ/api/supabase.dart';
import 'package:email_validator_flutter/email_validator_flutter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ValidateEmail {
  static bool validateEmail(String email) =>
      EmailValidatorFlutter().validateEmail(email);
}

class SuccessAuth {
  static Future<bool> successAuth(String email, String password) async {
    try {
      SupabaseInit().init();
      var sup = Supabase.instance.client;
      await sup.auth.signInWithPassword(password: password, email: email);
      return true;
    } catch (e) {
      throw Exception('Произошла ошибка: ' + e.toString());
    }
  }
}

class FailedAuth {}

class DialogPassword {}

class DialogEmail {}

class ValidatePassword {}
