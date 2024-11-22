import 'dart:ui';

import 'package:champ/functions/func.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/pages/otppage.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/presentation/widgets/button.dart';
import 'package:champ/presentation/widgets/emailnotification.dart';
import 'package:champ/presentation/widgets/textbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

TextEditingController email = TextEditingController();

class _ForgotPasswordState extends State<ForgotPassword> {
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
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
                'Забыл Пароль',
                style: myTextStyle(32, MyColors.text, null),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 150,
                child: Text(
                  textAlign: TextAlign.center,
                  'Введите Свою Учетную Запись Для Сброса',
                  style: myTextStyle(16, MyColors.subtextdark, null),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
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
                      height: 60,
                    ),
                    Button(
                      onTap: () {
                        Func().tryToResetPassword(email.text, context);
                      },
                      title: 'Отправить',
                      controller: null,
                      bgcolor: MyColors.accent,
                      titlecolor: Colors.white,
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
