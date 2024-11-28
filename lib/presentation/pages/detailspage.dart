import 'dart:typed_data';

import 'package:champ/functions/func.dart';
import 'package:champ/models/detailmodel.dart';
import 'package:champ/models/sneakermodel.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/pages/cartpage.dart';
import 'package:champ/presentation/pages/detailitem.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/presentation/widgets/arrowicon.dart';
import 'package:champ/riverpod/cartprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class DetailsPage extends ConsumerStatefulWidget {
  const DetailsPage({super.key, required this.sneakerid, required this.image});

  final String sneakerid;
  final Uint8List image;
  @override
  ConsumerState<DetailsPage> createState() => _DetailsPageState();
}

PageController pageController = PageController();

class _DetailsPageState extends ConsumerState<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => const CartPage()));
            },
            icon: Stack(
              children: [
                SvgPicture.asset(
                  'assets/cart.svg',
                ),
                cart.isNotEmpty
                    ? SizedBox(
                        width: 40,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Image.asset(
                            'assets/badge.png',
                            height: 10,
                            width: 10,
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ],
        centerTitle: true,
        title: Text(
          "Sneaker Shop",
          style: myTextStyle(16, MyColors.text, null),
        ),
        backgroundColor: MyColors.background,
        leading: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: MyColors.block, borderRadius: BorderRadius.circular(30)),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const ArrowIcon(),
          ),
        ),
      ),
      body: FutureBuilder(
          future: Func().getSneakersForDetail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No sneakers found.'));
            } else {
              List<DetailModel> details = snapshot.data!;
              return PageView.builder(
                controller: pageController,
                onPageChanged: (value) {},
                itemCount: details.length,
                itemBuilder: (context, index) {
                  return DetailItem(
                    sneakerid: details[index].sneakerid,
                    image: details[index].image,
                  );
                },
              );
            }
          }),
    );
  }
}
