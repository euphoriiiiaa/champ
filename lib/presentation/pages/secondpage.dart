import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/pages/onboardingpage.dart';
import 'package:champ/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key, required this.controller});

  final PageController controller;
  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
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
            colors: [MyColors.lighterBlue, MyColors.darkerBlue],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              fit: BoxFit.cover,
              width: 671,
              height: 360,
              'assets/second_onboard.png',
            ),
            SizedBox(
              width: 267,
              child: Text(
                textAlign: TextAlign.center,
                'Начнем путешествие',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 267,
              child: Text(
                textAlign: TextAlign.center,
                'Умная, великолепная и модная коллекция Изучите сейчас',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}