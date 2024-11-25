import 'package:champ/functions/func.dart';
import 'package:champ/models/sneakermodel.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/presentation/widgets/arrowicon.dart';
import 'package:champ/presentation/widgets/sneakeritem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/checked_heart.png',
            ),
          ),
        ],
        title: Text(
          'Избранное',
          textAlign: TextAlign.start,
          style: myTextStyle(16, MyColors.text, null),
        ),
        leading: IconButton(
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
          icon: SvgPicture.asset('assets/Hamburger.svg'),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width - 10,
        child: FutureBuilder(
            future: Func().getFavoriteSneakers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No sneakers favorites found.'));
              } else {
                List<SneakerModel> sneakers = snapshot.data!;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.8,
                    crossAxisCount: 2,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: sneakers.length,
                  itemBuilder: (context, index) {
                    return SneakerItem(
                      fullname: null,
                      bestseller: null,
                      description: null,
                      category: null,
                      height: 50,
                      width: 200,
                      name: sneakers[index].name,
                      price: sneakers[index].price,
                      id: sneakers[index].id,
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
