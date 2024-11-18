import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/pages/onboardingpage.dart';
import 'package:champ/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key, required this.controller});

  final PageController controller;
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/sparkles2.png'),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [MyColors.lighterBlue, MyColors.darkerBlue],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Image.asset(
                      fit: BoxFit.cover,
                      'assets/sparkles.png',
                      height: 110,
                    ),
                  ),
                  SizedBox(
                    width: 267,
                    child: Text(
                      textAlign: TextAlign.center,
                      'ДОБРО ПОЖАЛОВАТЬ',
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Image.asset(
                fit: BoxFit.cover,
                width: 671,
                height: 360,
                'assets/first_onboard.png',
              ),
            ],
          )),
    );
  }
}
