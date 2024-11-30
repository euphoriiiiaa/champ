import 'dart:developer';
import 'dart:ui';

import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/pages/profilepage.dart';
import 'package:champ/presentation/pages/favouritepage.dart';
import 'package:champ/presentation/pages/mainpage.dart';
import 'package:champ/presentation/pages/notificationspage.dart';
import 'package:champ/presentation/widgets/navbar.dart';
import 'package:champ/riverpod/cartprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPageView extends ConsumerStatefulWidget {
  const MainPageView({super.key});

  @override
  ConsumerState<MainPageView> createState() => _MainPageViewState();
}

final PageController myPageController = PageController();
int currentPage = 0;

class _MainPageViewState extends ConsumerState<MainPageView> {
  @override
  void initState() {
    super.initState();
    currentPage = 0;
  }

  @override
  void didChangeDependencies() {
    final cartNotifier = ref.read(cartProvider.notifier);
    cartNotifier.loadCart();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarColor: Colors.black),
      child: Scaffold(
        backgroundColor: MyColors.background,
        body: PageView(
          onPageChanged: (value) {
            setState(() {
              currentPage = value;
              log(value.toString());
            });
          },
          physics: const BouncingScrollPhysics(),
          controller: myPageController,
          children: const [
            MainPage(),
            FavouritePage(),
            NotificationsPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: NavBar(
          context: context,
          pageController: myPageController,
          currentPage: currentPage,
        ),
      ),
    );
  }
}
