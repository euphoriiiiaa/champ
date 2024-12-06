import 'package:email_validator_flutter/email_validator_flutter.dart';
import 'package:flutter/material.dart';

class PasswordValidatorWidget extends StatefulWidget {
  @override
  _PasswordValidatorWidgetState createState() =>
      _PasswordValidatorWidgetState();
}

class _PasswordValidatorWidgetState extends State<PasswordValidatorWidget> {
  final _formKey = GlobalKey<FormState>();
  String _password = '';

  static bool validatePassword(String password) {
    if ((password.length >= 4 && password.length <= 8) &&
        password.contains(RegExp(r'\d')) &&
        password.contains(RegExp(r'[A-Z]'))) {
      return true;
    } else {
      return false;
    }
  }

  void _validatePassword(String password, BuildContext contextt) {
    if (!validatePassword(password)) {
      showDialog(
        context: contextt,
        builder: (contextt) {
          return AlertDialog(
            title: Text('Ошибка'),
            content: Text('Некорректный Password'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
            decoration: InputDecoration(labelText: 'Password'),
          ),
          ElevatedButton(
            onPressed: () {
              _validatePassword(_password, context);
            },
            child: Text('Проверить'),
          ),
        ],
      ),
    );
  }
}
