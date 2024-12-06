import 'package:email_validator_flutter/email_validator_flutter.dart';

class ValidateEmail {
  static bool validateEmail(String email) =>
      EmailValidatorFlutter().validateEmail(email);
}

class SuccessAuth {
  static bool successAuth(String email, String password) {
    var user = {'email': 'baloonchannel2@gmail.com', 'password': '2122211'};

    if (user['email'] == email && user['password'] == password) {
      return true;
    } else {
      return false;
    }
  }
}

class FailedAuth {
  static bool failedAuth(String email, String password) {
    var user = {'email': 'baloonchannel2@gmail.com', 'password': '2122211'};

    if (user['email'] != email && user['password'] != password) {
      return true;
    } else {
      return false;
    }
  }
}

class ValidatePassword {
  static bool validatePassword(String password) {
    if ((password.length >= 4 && password.length <= 8) &&
        password.contains(RegExp(r'\d')) &&
        password.contains(RegExp(r'[A-Z]'))) {
      return true;
    } else {
      return false;
    }
  }
}
