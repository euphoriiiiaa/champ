import 'dart:developer';
import 'dart:ui';
import 'package:champ/functions/func.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/pages/signin.dart';
import 'package:champ/presentation/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:champ/presentation/widgets/textbox.dart';

class WritePassword extends StatefulWidget {
  const WritePassword({super.key, required this.onTap});

  final Function()? onTap;
  @override
  State<WritePassword> createState() => _WritePasswordState();
}

String genPass = '';
TextEditingController controller = TextEditingController();
TextEditingController genController = TextEditingController();

class _WritePasswordState extends State<WritePassword> {
  @override
  void dispose() {
    controller.clear();
    genController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - 50,
        height: MediaQuery.of(context).size.height - 500,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('assets/icon_modal.svg'),
            Text(
              textAlign: TextAlign.center,
              'Введите фразу, на основе которой будет сгенерирован пароль',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextBox(
              email: true,
              hint: 'Например: I_p0Mn|O_4y9n0e Mg№vEn|E',
              controller: controller,
              onSubmit: (value) {
                setState(() {
                  controller.text = value;
                  if (controller.text.isEmpty || controller.text.length < 6) {
                    log('empty or less than 6 chars');
                    return;
                  }
                  genPass = Func().genNewPassword(controller.text);
                  genController.text = genPass;
                  // Navigator.pop(context);
                  // Navigator.push(context,
                  //     CupertinoPageRoute(builder: (context) => const SignIn()));
                });
              },
            ),
            Text(
              textAlign: TextAlign.center,
              'Сгенерированный пароль',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextBox(
              onSubmit: null,
              email: true,
              hint: 'Новый пароль',
              controller: genController,
            ),
            GestureDetector(
              onTap: widget.onTap,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: MyColors.lighterBlue),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
