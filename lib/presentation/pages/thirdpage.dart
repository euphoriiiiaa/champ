import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key, required this.controller});

  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [MyColors.accent, MyColors.darkerBlue],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              fit: BoxFit.cover,
              width: 671,
              height: 360,
              'assets/third_onboard.png',
            ),
            SizedBox(
              width: 315,
              child: Text(
                  textAlign: TextAlign.center,
                  'У вас есть сила, Чтобы',
                  style: myTextStyle(34, Colors.white, null)),
            ),
            SizedBox(
              width: 267,
              child: Text(
                  textAlign: TextAlign.center,
                  'В вашей комнате много красивых и привлекательных растений',
                  style: myTextStyle(16, Colors.white, null)),
            ),
          ],
        ),
      ),
    );
  }
}
