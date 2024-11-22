import 'dart:developer';

import 'package:champ/functions/func.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/pages/forgotpassword.dart';
import 'package:champ/presentation/pages/regpage.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/presentation/widgets/button.dart';
import 'package:champ/presentation/widgets/textbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();

class _SignInState extends State<SignIn> {
  @override
  void dispose() {
    email.clear();
    password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.block,
      appBar: AppBar(
        backgroundColor: MyColors.block,
        leading: Container(
          margin: EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: MyColors.background,
              borderRadius: BorderRadius.circular(30)),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new_outlined),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Привет!',
                style: myTextStyle(32, MyColors.text, null),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                  textAlign: TextAlign.center,
                  'Заполните Свои данные или продолжите через социальные медиа',
                  style: myTextStyle(16, MyColors.subtextdark, null),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      child: Text(
                          textAlign: TextAlign.start,
                          'Email',
                          style: myTextStyle(16, MyColors.text, null)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      child: TextBox(
                        onSubmit: null,
                        controller: email,
                        email: true,
                        hint: 'xyz@gmail.com',
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      child: Text(
                        textAlign: TextAlign.start,
                        'Пароль',
                        style: myTextStyle(16, MyColors.text, null),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 50,
                      child: TextBox(
                        onSubmit: null,
                        controller: password,
                        email: false,
                        hint: '*********',
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      const ForgotPassword()));
                        },
                        child: Text(
                          textAlign: TextAlign.end,
                          'Восстановить',
                          style: myTextStyle(12, MyColors.subtextdark, null),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Button(
                      onTap: () {
                        Func().tryToSignIn(email.text, password.text, context);
                      },
                      title: 'Войти',
                      controller: null,
                      bgcolor: MyColors.accent,
                      titlecolor: Colors.white,
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(bottom: 20),
                height: MediaQuery.of(context).size.height - 650,
                width: MediaQuery.of(context).size.width - 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'Вы впервые?',
                      style: myTextStyle(16, MyColors.subtextdark, null),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        log('asd');
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const RegPage()));
                      },
                      child: Text(
                        textAlign: TextAlign.center,
                        'Создать пользователя',
                        style: myTextStyle(16, MyColors.text, null),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
