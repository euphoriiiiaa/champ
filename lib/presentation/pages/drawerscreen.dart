import 'dart:io';

import 'package:champ/functions/func.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/pages/cartpage.dart';
import 'package:champ/presentation/pages/mainpage.dart';
import 'package:champ/presentation/pages/mainpageview.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      slideWidth: 300,
      mainScreenScale: 0.4,
      angle: -3,
      borderRadius: 30,
      menuBackgroundColor: MyColors.accent,
      mainScreenTapClose: true,
      menuScreen: const MenuScreen(),
      mainScreen: const MainPageView(),
      openCurve: Curves.easeInOut,
      closeCurve: Curves.easeInOut,
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sup = Supabase.instance.client;
    return Scaffold(
      backgroundColor: MyColors.accent,
      body: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ClipOval(
                    child: sup.auth.currentUser != null
                        ? Image.network(
                            width: 96,
                            height: 96,
                            sup.auth.currentUser!.userMetadata!['urlAvatar']
                                .toString(),
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            width: 96,
                            height: 96,
                            'assets/avatar.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  sup.auth.currentUser != null
                      ? sup.auth.currentUser!.userMetadata!['name']
                      : 'null',
                  textAlign: TextAlign.start,
                  style: myTextStyle(20, Colors.white, null),
                ),
                SizedBox(
                  height: 58,
                ),
                GestureDetector(
                  onTap: () {
                    ZoomDrawer.of(context)!.close();
                    myPageController.jumpToPage(3);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/person.png',
                        width: 22,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 22,
                      ),
                      Text(
                        'Профиль',
                        textAlign: TextAlign.start,
                        style: myTextStyle(16, Colors.white, null),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => CartPage()));
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/cart.png',
                        width: 22,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 22,
                      ),
                      Text(
                        'Корзина',
                        textAlign: TextAlign.start,
                        style: myTextStyle(16, Colors.white, null),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    ZoomDrawer.of(context)!.close();
                    myPageController.jumpToPage(1);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/favourite_drawer.png',
                        width: 22,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 22,
                      ),
                      Text(
                        'Избранное',
                        textAlign: TextAlign.start,
                        style: myTextStyle(16, Colors.white, null),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/delivery_drawer.png',
                      width: 22,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 22,
                    ),
                    Text(
                      'Заказы',
                      textAlign: TextAlign.start,
                      style: myTextStyle(16, Colors.white, null),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    ZoomDrawer.of(context)!.close();
                    myPageController.jumpToPage(2);
                  },
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/notification.png',
                        width: 22,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 22,
                      ),
                      Text(
                        'Уведомления',
                        textAlign: TextAlign.start,
                        style: myTextStyle(16, Colors.white, null),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/settings_drawer.png',
                      width: 22,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 22,
                    ),
                    Text(
                      'Настройки',
                      textAlign: TextAlign.start,
                      style: myTextStyle(16, Colors.white, null),
                    ),
                  ],
                ),
                SizedBox(
                  height: 38,
                ),
                Divider(
                  color: Colors.white.withOpacity(0.23),
                  thickness: 1,
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () => Func().exitFromApp(),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/exit_drawer.png',
                        width: 22,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 22,
                      ),
                      Text(
                        'Выйти',
                        textAlign: TextAlign.start,
                        style: myTextStyle(16, Colors.white, null),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
