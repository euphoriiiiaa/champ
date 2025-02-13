import 'dart:developer';
import 'dart:ui';

import 'package:champ/data/data.dart';
import 'package:champ/functions/func.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/pages/mainpageview.dart';
import 'package:champ/presentation/widgets/button.dart';
import 'package:champ/presentation/widgets/textbox.dart';
import 'package:champ/presentation/widgets/timer.dart';
import 'package:champ/riverpod/timerprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OtpPage extends ConsumerStatefulWidget {
  const OtpPage({super.key});

  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

TextEditingController otp = TextEditingController();

class _OtpPageState extends ConsumerState<OtpPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(timer.notifier).startTimer();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Container(
        margin: EdgeInsets.all(6),
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
                'OTP Проверка',
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
                  'Пожалуйста, проверьте свою электронную почту, чтобы увидеть код подтверждения',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: Text(
                  textAlign: TextAlign.start,
                  'OTP Код',
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 50,
                child: OtpTextField(
                  handleControllers: (controllers) => otp,
                  onSubmit: (value) {
                    if (value.toUpperCase() == Data.otpCode) {
                      Func().successOtp(context);
                      log('success');
                    } else {
                      log('wrong code');
                    }
                  },
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.05),
                  borderWidth: 0,
                  focusedBorderColor: Colors.red,
                  fieldHeight: 100,
                  fieldWidth: 46,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  numberOfFields: 6,
                  showFieldAsBox: true,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (ref.watch(timer) > 0) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                "Время для повторной отправки еще не закончилось. Попробуйте позже."),
                          ));
                        } else {
                          Func().sendAnotherMessage(context);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Сообщение отправлено еще раз."),
                          ));
                          // Перезапуск таймера
                          ref.read(timer.notifier).startTimer();
                        }
                      },
                      child: Text(
                        'Отправить заново',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    TimerWidget(),
                  ],
                ),
              ),
              // Button(
              //   title: 'next',
              //   controller: null,
              //   bgcolor: MyColors.darkerBlue,
              //   titlecolor: Colors.white,
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         CupertinoPageRoute(
              //             builder: (context) => const MainPageView()));
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
