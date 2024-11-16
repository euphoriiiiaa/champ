import 'package:champ/presentation/pages/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.title,
      required this.controller,
      required this.bgcolor,
      required this.titlecolor,
      required this.onTap});

  final PageController? controller;
  final String title;
  final Color bgcolor;
  final Color titlecolor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - 50,
        height: 50,
        decoration: BoxDecoration(
            color: bgcolor, borderRadius: BorderRadius.circular(13)),
        child: Text(
          title,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(fontWeight: FontWeight.w600, color: titlecolor),
          ),
        ),
      ),
    );
  }
}
