import 'dart:typed_data';

import 'package:champ/models/cartmodel.dart';
import 'package:champ/models/sneakercartmodel.dart';
import 'package:champ/models/sneakermodel.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/riverpod/cartprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class CartItem extends ConsumerStatefulWidget {
  const CartItem(
      {super.key,
      required this.id,
      required this.image,
      required this.name,
      required this.price,
      required this.count});

  final Uint8List image;
  final String id;
  final String name;
  final double price;
  final int count;

  @override
  ConsumerState<CartItem> createState() => _CartItemState();
}

class _CartItemState extends ConsumerState<CartItem> {
  @override
  Widget build(BuildContext context) {
    final cartNotifier = ref.read(cartProvider.notifier);
    return widget.count != 1
        ? SwipeableTile.swipeToTriggerCard(
            shadow: BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 1,
              blurStyle: BlurStyle.outer,
            ),
            verticalPadding: 10,
            horizontalPadding: 10,
            borderRadius: 20,
            color: Colors.white,
            direction: SwipeDirection.horizontal,
            onSwiped: (direction) {
              if (direction == SwipeDirection.endToStart) {
                if (widget.count == 1) {
                  cartNotifier.removeFromCart(widget.id);
                } else {
                  cartNotifier.updateCount(widget.id, widget.count - 1);
                }
              } else if (direction == SwipeDirection.startToEnd) {
                cartNotifier.updateCount(widget.id, widget.count + 1);
              }
            },
            backgroundBuilder: (context, direction, progress) {
              if (direction == SwipeDirection.startToEnd) {
                return Container(
                  color: MyColors.accent,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10),
                  child: SvgPicture.asset(
                    'assets/plus.svg',
                  ),
                );
              } else if (direction == SwipeDirection.endToStart) {
                return Container(
                  color: MyColors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                );
              }
              return Container();
            },
            key: UniqueKey(),
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.memory(
                    widget.image,
                    height: 120,
                    width: 140,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: myTextStyle(20, MyColors.text, null),
                      ),
                      Text(
                        'Р ${widget.price}',
                        style: myTextStyle(16, MyColors.text, null),
                      ),
                      Text(
                        'Количество ${widget.count} шт.',
                        style: myTextStyle(16, MyColors.text, null),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        : SwipeableTile.card(
            shadow: BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 1,
              blurStyle: BlurStyle.outer,
            ),
            verticalPadding: 10,
            horizontalPadding: 10,
            borderRadius: 20,
            color: Colors.white,
            direction: SwipeDirection.horizontal,
            onSwiped: (direction) {
              if (direction == SwipeDirection.endToStart) {
                if (widget.count == 1) {
                  cartNotifier.removeFromCart(widget.id);
                } else {
                  cartNotifier.updateCount(widget.id, widget.count - 1);
                }
              } else if (direction == SwipeDirection.startToEnd) {
                cartNotifier.updateCount(widget.id, widget.count + 1);
              }
            },
            backgroundBuilder: (context, direction, progress) {
              if (direction == SwipeDirection.startToEnd) {
                return Container(
                  color: MyColors.accent,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10),
                  child: SvgPicture.asset(
                    'assets/plus.svg',
                  ),
                );
              } else if (direction == SwipeDirection.endToStart) {
                return Container(
                  color: MyColors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                  ),
                );
              }
              return Container();
            },
            key: UniqueKey(),
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.memory(
                    widget.image,
                    height: 120,
                    width: 140,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: myTextStyle(20, MyColors.text, null),
                      ),
                      Text(
                        'Р ${widget.price}',
                        style: myTextStyle(16, MyColors.text, null),
                      ),
                      Text(
                        'Количество ${widget.count} шт.',
                        style: myTextStyle(16, MyColors.text, null),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
