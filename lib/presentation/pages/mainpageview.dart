import 'dart:developer';
import 'dart:ui';

import 'package:champ/functions/func.dart';
import 'package:champ/models/categorymodel.dart';
import 'package:champ/models/sneakermodel.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/pages/mainpage.dart';
import 'package:champ/presentation/widgets/navbar.dart';
import 'package:champ/presentation/widgets/sneakeritem.dart';
import 'package:champ/presentation/widgets/tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({super.key});

  @override
  State<MainPageView> createState() => _MainPageViewState();
}

PageController pageController = PageController();
int currentPage = 0;

class _MainPageViewState extends State<MainPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff7f7f9),
        body: PageView(
          onPageChanged: (value) {
            setState(() {
              currentPage = value;
              log(value.toString());
            });
          },
          physics: const BouncingScrollPhysics(),
          controller: pageController,
          children: [
            mainPage(context),
            mainPage(context),
            mainPage(context),
            mainPage(context),
          ],
        ),
        bottomNavigationBar: NavBar(
          context: context,
          pageController: pageController,
          currentPage: currentPage,
        ));
  }
}
