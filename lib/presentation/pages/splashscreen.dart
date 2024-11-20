import 'package:champ/presentation/pages/mainpageview.dart';
import 'package:champ/presentation/pages/onboardingpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _nextScreen();
  }

  void _nextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    Navigator.push(context,
        CupertinoPageRoute(builder: (context) => const MainPageView()));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: Colors.black),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/splash.png'),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Image.asset(
              width: 331,
              height: 76,
              fit: BoxFit.cover,
              'assets/splash_logo.png',
            ),
          ),
        ),
      ),
    );
  }
}
