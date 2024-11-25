import 'dart:typed_data';

import 'package:champ/functions/func.dart';
import 'package:champ/models/cartmodel.dart';
import 'package:champ/models/sneakermodel.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/riverpod/cartprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SneakerItem extends ConsumerStatefulWidget {
  const SneakerItem(
      {super.key,
      required this.id,
      required this.name,
      required this.price,
      required this.category,
      required this.description,
      required this.bestseller,
      required this.fullname,
      required this.height,
      required this.width,
      requ});

  final String name;
  final double price;
  final String? id;
  final double height;
  final double width;
  final int? category;
  final String? description;
  final bool? bestseller;
  final String? fullname;

  @override
  ConsumerState<SneakerItem> createState() => _SneakerItemState();
}

class _SneakerItemState extends ConsumerState<SneakerItem> {
  Future<Uint8List?>? imageFuture;
  bool? isFavorite = false;

  @override
  void initState() {
    super.initState();
    imageFuture = Func().getSneakerImage(widget.id!);
    Future.microtask(() async {
      isFavorite = await Func().checkIfSneakerFavorite(widget.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: MyColors.block),
        child: FutureBuilder<Uint8List?>(
          future: imageFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(
                child: Text('No image available'),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      isFavorite!
                          ? IconButton(
                              onPressed: () {
                                Func().unselectFavorite(widget.id!);
                                setState(() {
                                  isFavorite = false;
                                });
                              },
                              icon: Image.asset(
                                height: 28,
                                width: 28,
                                'assets/checked_heart.png',
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                Func().selectFavorite(widget.id!);
                                setState(() {
                                  isFavorite = true;
                                });
                              },
                              icon: Image.asset(
                                height: 28,
                                width: 28,
                                'assets/unchecked_heart.png',
                              ),
                            ),
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      width: widget.width,
                      child: Image.memory(
                        snapshot.data!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'BEST SELLER',
                          textAlign: TextAlign.start,
                          style: myTextStyle(12, MyColors.accent, null),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          widget.name,
                          textAlign: TextAlign.start,
                          style: myTextStyle(16, MyColors.subtextdark, null),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          '₽ ${widget.price}',
                          textAlign: TextAlign.start,
                          style: myTextStyle(16, MyColors.text, null),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          var sneaker = await Func()
                              .getSneakerToCart(widget.id!, snapshot.data!);
                          if (sneaker != null) {
                            if (!cart.containsKey(widget.id)) {
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
                          padding: EdgeInsets.all(8),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: MyColors.accent,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15)),
                          ),
                          child: cartNotifier.checkIfAlreadyInCart(widget.id!)
                              ? SvgPicture.asset('assets/have_cart.svg')
                              : SvgPicture.asset('assets/plus.svg'),
                        ),
                      )
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
