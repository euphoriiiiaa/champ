import 'dart:typed_data';

import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/riverpod/cartprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:humanize_duration/humanize_duration.dart';
import 'package:swipeable_tile/swipeable_tile.dart';

class OrderItem extends ConsumerStatefulWidget {
  const OrderItem(
      {super.key,
      required this.idorder,
      required this.createdat,
      required this.sneakername,
      required this.total,
      required this.image});

  final String createdat;
  final String sneakername;
  final double total;
  final Uint8List image;
  final int idorder;

  @override
  ConsumerState<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends ConsumerState<OrderItem> {
  @override
  Widget build(BuildContext context) {
    final cartNotifier = ref.read(cartProvider.notifier);
    return SwipeableTile.swipeToTriggerCard(
      shadow: BoxShadow(),
      verticalPadding: 10,
      horizontalPadding: 10,
      borderRadius: 20,
      color: Colors.white,
      direction: SwipeDirection.horizontal,
      onSwiped: (direction) async {
        if (direction == SwipeDirection.startToEnd) {
          cartNotifier.repeatCart(widget.idorder);
          // Future.delayed(Duration(seconds: 3), () {
          //   cartNotifier.loadCart();
          // });
        }
      },
      backgroundBuilder: (context, direction, progress) {
        if (direction == SwipeDirection.startToEnd) {
          return Container(
            color: MyColors.accent,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10),
            child: Image.asset(
              'assets/repeat_order.png',
              height: 32,
              width: 32,
            ),
          );
        } else if (direction == SwipeDirection.endToStart) {
          return Container(
            color: MyColors.red,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10),
            child: Image.asset(
              'assets/cancel_order.png',
              height: 32,
              width: 32,
            ),
          );
        }
        return Container();
      },
      key: UniqueKey(),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: MyColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Image.memory(
                    widget.image,
                    height: 100,
                    width: 100,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.sneakername,
                        style: myTextStyle(14, MyColors.text, null),
                      ),
                      Row(
                        children: [
                          Text(
                            '₽ ${widget.total}',
                            style: myTextStyle(14, MyColors.text, null),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '₽ ${(widget.total / 100).toStringAsFixed(2)}',
                            style: myTextStyle(14, MyColors.hint, null),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                DateTime.parse(widget.createdat).day == DateTime.now().day
                    ? '${humanizeDuration(
                        language: const RuLanguage(),
                        Duration(
                          minutes: (DateTime.now().minute -
                              DateTime.parse(widget.createdat).minute),
                        ),
                      )} назад'
                    : '${DateTime.parse(widget.createdat).hour}:${DateTime.parse(widget.createdat).minute}',
                style: myTextStyle(14, MyColors.hint, null),
              ),
            )
          ],
        ),
      ),
    );
  }
}
