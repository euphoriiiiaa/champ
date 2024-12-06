import 'package:email_validator_flutter/email_validator_flutter.dart';
import 'package:flutter/material.dart';

class EmailValidatorWidget extends StatefulWidget {
  @override
  _EmailValidatorWidgetState createState() => _EmailValidatorWidgetState();
}

class _EmailValidatorWidgetState extends State<EmailValidatorWidget> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';

  void _validateEmail(String email, BuildContext contextt) {
    if (!EmailValidatorFlutter().validateEmail(email)) {
      showDialog(
        context: contextt,
        builder: (contextt) {
          return AlertDialog(
            title: Text('Ошибка'),
            content: Text('Некорректный Email'),
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
                _email = value;
              });
            },
            decoration: InputDecoration(labelText: 'Email'),
          ),
          ElevatedButton(
            onPressed: () {
              _validateEmail(_email, context);
            },
            child: Text('Проверить'),
          ),
        ],
      ),
    );
  }
}
