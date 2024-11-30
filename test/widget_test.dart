// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:champ/api/supabase.dart';
import 'package:email_validator_flutter/email_validator_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:champ/main.dart';

import 'tests.dart';

void main() {
  test('Валидация Email', () {
    bool result = ValidateEmail.validateEmail('asd');
    expect(result, false);
  });

  test('Успешная авторизация', () async {
    bool result =
        await SuccessAuth.successAuth('baloonchannel2@gmail.com', '2122211');
    expect(result, true);
  });
}
