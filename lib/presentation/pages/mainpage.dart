import 'dart:developer';

import 'package:champ/functions/func.dart';
import 'package:champ/models/adsmodel.dart';
import 'package:champ/models/categorymodel.dart';
import 'package:champ/models/sneakermodel.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/pages/popularpage.dart';
import 'package:champ/presentation/pages/searchpage.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/presentation/widgets/adwidget.dart';
import 'package:champ/presentation/widgets/sneakeritem.dart';
import 'package:champ/presentation/widgets/tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SvgPicture.asset('assets/title.svg'),
            ),
            Text('Главная',
                textAlign: TextAlign.start,
                style: myTextStyle(32, MyColors.text, null)),
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
            ZoomDrawer.of(context)!.toggle();
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
                          hintStyle: myTextStyle(12, MyColors.hint, null),
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
                  style: myTextStyle(16, MyColors.text, null),
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
                    style: myTextStyle(16, MyColors.text, null),
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
                      style: myTextStyle(16, MyColors.accent, null),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 700,
                child: FutureBuilder(
                  future: Func().getPopularSneakers(),
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
                          width: 160,
                          height: 182,
                          child: SneakerItem(
                            fullname: null,
                            bestseller: null,
                            description: null,
                            category: null,
                            height: 200,
                            width: 200,
                            name: sneakersList[index].name,
                            price: sneakersList[index].price,
                            id: sneakersList[index].id,
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
                    style: myTextStyle(16, MyColors.text, null),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Все',
                      textAlign: TextAlign.start,
                      style: myTextStyle(16, MyColors.accent, null),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                child: FutureBuilder<List<AdsModel>>(
                  future: Func().getAds(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No ads found.'));
                    } else {
                      List<AdsModel> ads = snapshot.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: ads.length,
                        itemBuilder: (context, index) {
                          return AdWidget(uuid: ads[index].id);
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
