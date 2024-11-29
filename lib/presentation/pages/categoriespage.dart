import 'package:champ/functions/func.dart';
import 'package:champ/models/categorymodel.dart';
import 'package:champ/models/sneakermodel.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/presentation/widgets/arrowicon.dart';
import 'package:champ/presentation/widgets/sneakeritem.dart';
import 'package:champ/presentation/widgets/tile.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key, required this.title});

  final String title;
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

String titlewidget = '';
List<SneakerModel> sneakers = [];

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  void initState() {
    titlewidget = widget.title;
    super.initState();
  }

  @override
  void dispose() {
    sneakers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
          centerTitle: true,
          forceMaterialTransparency: true,
          title: Text(
            titlewidget,
            textAlign: TextAlign.start,
            style: myTextStyle(16, MyColors.text, null),
          ),
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const ArrowIcon())),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 60,
              child: FutureBuilder<List<CategoryModel>>(
                future: Func().getCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No categories found.'));
                  } else {
                    List<CategoryModel> categories = snapshot.data!;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return tile(categories[index].name, titlewidget,
                            () async {
                          sneakers = await Func()
                              .getSneakersForCategories(categories[index].name);
                          setState(() {
                            titlewidget = categories[index].name;
                          });
                        });
                      },
                    );
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              child: FutureBuilder(
                  future: Func().getSneakersForCategories(widget.title),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text('No sneakers favorites found.'));
                    } else {
                      if (sneakers.isEmpty) {
                        sneakers = snapshot.data!;
                      }
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
          ),
        ],
      ),
    );
  }
}
