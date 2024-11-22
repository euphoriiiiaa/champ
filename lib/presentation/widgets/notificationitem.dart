import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationItem extends StatefulWidget {
  const NotificationItem(
      {super.key,
      required this.header,
      required this.body,
      required this.created_at,
      required this.readed});

  final String header;
  final String body;
  final DateTime created_at;
  final bool readed;

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: MyColors.block, borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.header,
                          style: myTextStyle(16, MyColors.text, null)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.body,
                        style: myTextStyle(12, MyColors.text, null),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(widget.created_at.toString(),
                          style: myTextStyle(12, MyColors.subtextdark, null)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          widget.readed
              ? const SizedBox()
              : Align(
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    'assets/badge.png',
                    height: 10,
                    width: 10,
                  ),
                ),
        ],
      ),
    );
  }
}
