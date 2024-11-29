import 'dart:developer';
import 'dart:typed_data';

import 'package:champ/functions/func.dart';
import 'package:champ/models/sneakermodel.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/pages/cartpage.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/presentation/widgets/arrowicon.dart';
import 'package:champ/presentation/widgets/button.dart';
import 'package:champ/riverpod/cartprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class DetailItem extends ConsumerStatefulWidget {
  const DetailItem({super.key, required this.sneakerid, this.image});

  final String sneakerid;
  final Uint8List? image;
  @override
  ConsumerState<DetailItem> createState() => _DetailsPageState();
}

bool isDescRevealed = false;
bool? isFavorite;
String id = '';
List<Uint8List>? listImagesFirst = [];

class _DetailsPageState extends ConsumerState<DetailItem> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      isFavorite = await Func().checkIfSneakerFavorite(widget.sneakerid);
      id = widget.sneakerid;
      listImagesFirst = await Func().getAllSneakersImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    return Scaffold(
      backgroundColor: MyColors.background,
      body: FutureBuilder(
        future: Func().getSneakers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No sneakers found.'));
          } else {
            List<SneakerModel> sneakers = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sneakers.where((item) => item.id == id).first.name,
                    style: myTextStyle(26, MyColors.text, null),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    "Men's shoes",
                    style: myTextStyle(16, MyColors.subtextdark, null),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    '₽ ${sneakers.where((item) => item.id == widget.sneakerid).first.price}',
                    style: myTextStyle(26, MyColors.text, null),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    height: 250,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('assets/podium.png'),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 60),
                          child: Image.memory(
                            widget.image!,
                            width: 350,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 60,
                    child: FutureBuilder(
                      future: Func().getAllSneakersImages(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('No images found.'));
                        } else {
                          var listImages = snapshot.data!;
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: listImages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(right: 20),
                                width: 60,
                                decoration: BoxDecoration(
                                  border:
                                      (sneakers[index].id == widget.sneakerid
                                          ? Border.all(
                                              color: MyColors.accent, width: 2)
                                          : null),
                                  color: MyColors.block,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Image.memory(listImages[index]),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 120,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            maxLines: !isDescRevealed ? 3 : null,
                            sneakers
                                .where((item) => item.id == widget.sneakerid)
                                .first
                                .description!,
                            style: myTextStyle(16, MyColors.subtextdark, null),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              !isDescRevealed
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isDescRevealed = !isDescRevealed;
                                        });
                                      },
                                      child: Text(
                                        'Подробнее',
                                        style: myTextStyle(
                                            14, MyColors.accent, null),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isDescRevealed = !isDescRevealed;
                                        });
                                      },
                                      child: Text(
                                        'Скрыть',
                                        style: myTextStyle(
                                            14, MyColors.accent, null),
                                      ),
                                    )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isFavorite!
                          ? IconButton(
                              onPressed: () {
                                Func().unselectFavorite(widget.sneakerid);
                                setState(() {
                                  isFavorite = false;
                                });
                              },
                              icon: Image.asset(
                                height: 60,
                                width: 60,
                                'assets/checked_heart.png',
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                Func().selectFavorite(widget.sneakerid);
                                setState(() {
                                  isFavorite = true;
                                });
                              },
                              icon: Image.asset(
                                height: 50,
                                width: 50,
                                'assets/unchecked_heart.png',
                              ),
                            ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            var sneaker = await Func().getSneakerToCart(
                                widget.sneakerid, widget.image!);
                            if (sneaker != null) {
                              if (!cart.containsKey(widget.sneakerid)) {
                                ref
                                    .read(cartProvider.notifier)
                                    .addToCart(sneaker);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'sneaker added to cart ${sneaker.name}'),
                                  ),
                                );
                                setState(() {});
                              } else {
                                cartNotifier.updateCount(
                                    sneaker.id, sneaker.count! + 1);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      'sneaker is already added, increase count'),
                                ));
                                setState(() {});
                              }
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width - 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: MyColors.accent,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/bag_button.png',
                                  width: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  cartNotifier.checkIfAlreadyInCart(
                                          widget.sneakerid)
                                      ? 'Добавлено'
                                      : 'В корзину',
                                  style: myTextStyle(14, Colors.white, null),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
