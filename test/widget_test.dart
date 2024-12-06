import 'dart:math';

import 'package:champ/presentation/widgets/emailvalidator.dart';
import 'package:champ/presentation/widgets/passwordvalidator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'tests.dart';

void main() {
  test('Валидация Email', () {
    bool result = ValidateEmail.validateEmail('remm1e@yandex.ru');
    expect(result, true);
  });

  test('Успешная авторизация', () {
    bool result =
        SuccessAuth.successAuth('baloonchannel2@gmail.com', '123123123');
    expect(result, true);
  });

  test('Провальная авторизация', () {
    bool result = FailedAuth.failedAuth('baloonchannel2@gmail.com', '2122211');
    expect(result, false);
  });

  test('Валидация пароля', () {
    bool result = ValidatePassword.validatePassword('Asdfg5');
    expect(result, true);
  });

  testWidgets('Show dialog after invalid email', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: EmailValidatorWidget(),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'asd');

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Некорректный Email'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
  });

  testWidgets('Show dialog after invalid password',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PasswordValidatorWidget(),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'Fasdg4');

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Некорректный Password'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
  });
}
