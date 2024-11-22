import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget tile(String title, Function()? onTap) {
  var tile = GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(right: 10, top: 10),
      child: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          height: 40,
          width: 130,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: MyColors.block),
          child: Text(
            title,
            style: myTextStyle(12, MyColors.text, null),
          ),
        ),
      ),
    ),
  );
  return tile;
}
