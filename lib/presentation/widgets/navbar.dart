import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/pages/mainpageview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar(
      {super.key,
      required this.context,
      required this.pageController,
      required this.currentPage});

  final BuildContext context;
  final PageController pageController;
  final int currentPage;
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/navbar_background.png',
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          pageController.jumpToPage(0);
                        });
                      },
                      child: Image.asset(
                        color: (widget.currentPage == 0)
                            ? MyColors.lighterBlue
                            : null,
                        'assets/home.png',
                        height: 24,
                        width: 22,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          pageController.jumpToPage(1);
                        });
                      },
                      child: Image.asset(
                        color: (widget.currentPage == 1)
                            ? MyColors.lighterBlue
                            : null,
                        'assets/heartt.png',
                        height: 24,
                        width: 22,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          pageController.jumpToPage(2);
                        });
                      },
                      child: Image.asset(
                        color: (widget.currentPage == 2)
                            ? MyColors.lighterBlue
                            : null,
                        'assets/notification.png',
                        height: 24,
                        width: 22,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          pageController.jumpToPage(3);
                        });
                      },
                      child: Image.asset(
                        color: (widget.currentPage == 3)
                            ? MyColors.lighterBlue
                            : null,
                        'assets/person.png',
                        height: 24,
                        width: 22,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              width: 110,
              height: 110,
              'assets/navbar_carticon.png',
            ),
          ],
        )
      ],
    );
  }
}
