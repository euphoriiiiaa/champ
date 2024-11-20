import 'dart:developer';

import 'package:champ/functions/func.dart';
import 'package:champ/models/categorymodel.dart';
import 'package:champ/models/sneakermodel.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/pages/popularpage.dart';
import 'package:champ/presentation/pages/searchpage.dart';
import 'package:champ/presentation/widgets/navbar.dart';
import 'package:champ/presentation/widgets/sneakeritem.dart';
import 'package:champ/presentation/widgets/tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget mainPage(BuildContext context) {
  return Scaffold(
    backgroundColor: Color(0xfff7f7f9),
    appBar: AppBar(
      forceMaterialTransparency: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: SvgPicture.asset('assets/title.svg'),
          ),
          Text(
            'Главная',
            textAlign: TextAlign.start,
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('assets/cart.svg'),
        ),
      ],
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: SvgPicture.asset('assets/Hamburger.svg'),
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Material(
                    elevation: 3,
                    shadowColor: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadiusDirectional.circular(20),
                    child: TextField(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const Searchpage()));
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        hintText: 'Поиск',
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    log('clicked');
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: const Color(0xff48B2E7),
                    ),
                    child: SvgPicture.asset(
                      'assets/sliders.svg',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: Text(
                'Категории',
                textAlign: TextAlign.start,
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              child: FutureBuilder<List<CategoryModel>>(
                future: Func().getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No categories found.'));
                  } else {
                    List<CategoryModel> categories = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return tile(categories[index].name, null);
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Популярные',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const PopularPage()));
                  },
                  child: Text(
                    'Все',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: MyColors.lighterBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 700,
              child: FutureBuilder(
                future: Func().getSneakers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No sneakers found.'));
                  } else {
                    List<SneakerModel> sneakersList = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sneakersList.length,
                      itemBuilder: (context, index) => SizedBox(
                        width: 170,
                        child: SneakerItem(
                          height: 50,
                          width: 200,
                          name: sneakersList[index].name,
                          price: sneakersList[index].price,
                          uuid: sneakersList[index].id,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Акции',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.raleway(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Все',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: MyColors.lighterBlue,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width - 50,
              height: MediaQuery.of(context).size.height - 820,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Summer Sale',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '15% OFF',
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/splash_logo.png',
                    color: Colors.black,
                    fit: BoxFit.contain,
                    width: 150,
                    height: 200,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
