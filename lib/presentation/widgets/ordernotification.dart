import 'dart:ui';

import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget orderNotification(BuildContext context) {
  return Center(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - 50,
        height: MediaQuery.of(context).size.height - 500,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/ordernotification_image.png',
              width: 160,
              height: 160,
            ),
            SizedBox(
              width: 150,
              child: Text(
                textAlign: TextAlign.center,
                'Вы успешно оформили заказ',
                style: GoogleFonts.raleway(
                    textStyle:
                        myTextStyle(20, MyColors.text, TextDecoration.none)),
              ),
            ),
            Button(
                title: 'Вернуться к покупкам',
                controller: null,
                bgcolor: MyColors.accent,
                titlecolor: Colors.white,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    ),
  );
}
