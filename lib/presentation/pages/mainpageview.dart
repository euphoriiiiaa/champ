import 'dart:developer';
import 'dart:ui';

import 'package:champ/presentation/pages/accountpage.dart';
import 'package:champ/presentation/pages/favouritepage.dart';
import 'package:champ/presentation/pages/mainpage.dart';
import 'package:champ/presentation/pages/notificationspage.dart';
import 'package:champ/presentation/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: Colors.black),
      child: Scaffold(
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
              FavouritePage(),
              NotificationsPage(),
              AccountPage(),
            ],
          ),
          bottomNavigationBar: NavBar(
            context: context,
            pageController: pageController,
            currentPage: currentPage,
          )),
    );
  }
}
