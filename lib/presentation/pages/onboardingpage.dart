import 'dart:developer';

import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/pages/firstpage.dart';
import 'package:champ/presentation/pages/secondpage.dart';
import 'package:champ/presentation/pages/signin.dart';
import 'package:champ/presentation/pages/thirdpage.dart';
import 'package:champ/presentation/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

PageController controller = PageController();
int currentPage = 0;
bool? isFirstPage;

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: MyColors.darkerBlue),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                controller: controller,
                physics: const BouncingScrollPhysics(),
                children: [
                  FirstPage(controller: controller),
                  SecondPage(controller: controller),
                  ThirdPage(controller: controller)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SmoothPageIndicator(
                onDotClicked: (dot) {
                  controller.animateToPage(dot,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                },
                controller: controller,
                count: 3,
                effect: WormEffect(
                  dotColor: Colors.black.withOpacity(0.5),
                  activeDotColor: Colors.white,
                  dotHeight: 5,
                  dotWidth: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60),
              child: Button(
                onTap: () {
                  if (controller.page != 2) {
                    controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  } else {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const SignIn()));
                  }
                },
                bgcolor: Colors.white,
                titlecolor: Colors.black,
                title: currentPage == 0 ? 'Начать' : 'Далее',
                controller: controller,
              ),
            )
          ],
        ),
      ),
    );
  }
}
