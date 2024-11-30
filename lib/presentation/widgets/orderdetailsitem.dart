import 'dart:typed_data';

import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:humanize_duration/humanize_duration.dart';

class OrderDetailsItem extends StatefulWidget {
  const OrderDetailsItem(
      {super.key,
      required this.sneakername,
      required this.cost,
      required this.image,
      required this.count});

  final String sneakername;
  final double cost;
  final Uint8List image;
  final int count;

  @override
  State<OrderDetailsItem> createState() => _OrderDetailsItemState();
}

class _OrderDetailsItemState extends State<OrderDetailsItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: MyColors.block,
        borderRadius: BorderRadius.circular(10),
      ),
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
                          '₽ ${widget.cost}',
                          style: myTextStyle(14, MyColors.text, null),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${widget.count} шт.',
                          style: myTextStyle(14, MyColors.hint, null),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
