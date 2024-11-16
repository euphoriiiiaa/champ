import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget emailNotification(BuildContext context) {
  var emailNotification = Center(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - 50,
        height: MediaQuery.of(context).size.height - 700,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset('assets/icon_modal.svg'),
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
  );

  return emailNotification;
}
