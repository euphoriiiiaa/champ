import 'dart:ui';

import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/widgets/button.dart';
import 'package:champ/presentation/widgets/textbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
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
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 150,
                child: Text(
                  textAlign: TextAlign.center,
                  'Введите Свою Учетную Запись Для Сброса',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
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
                        email: true,
                        hint: 'xyz@gmail.com',
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Button(
                      onTap: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) => Center(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 25, horizontal: 20),
                                      alignment: Alignment.center,
                                      width:
                                          MediaQuery.of(context).size.width - 50,
                                      height: MediaQuery.of(context).size.height -
                                          700,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.white),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icon_modal.svg'),
                                          Text(
                                            textAlign: TextAlign.center,
                                            'Проверьте Ваш Email',
                                            style: GoogleFonts.raleway(
                                              textStyle: TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            textAlign: TextAlign.center,
                                            'Мы отправили код восстановления пароля на вашу электронную почту.',
                                            style: GoogleFonts.raleway(
                                              textStyle: TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                      },
                      title: 'Отправить',
                      controller: null,
                      bgcolor: MyColors.lighterBlue,
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
