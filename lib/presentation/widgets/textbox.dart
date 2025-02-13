import 'dart:developer';

import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextBox extends StatefulWidget {
  const TextBox(
      {super.key,
      required this.email,
      required this.hint,
      required this.controller,
      required this.onSubmit});

  final bool email;
  final String hint;
  final TextEditingController? controller;
  final Function(String)? onSubmit;
  @override
  State<TextBox> createState() => _TextBoxState();
}

bool isRevealed = false;

class _TextBoxState extends State<TextBox> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
        obscureText: widget.email ? false : isRevealed,
        onSubmitted: widget.onSubmit,
        // inputFormatters: widget.email
        //     ? [FilteringTextInputFormatter.allow(RegExp(r'[a-zа-я]'))]
        //     : null,
        keyboardType: widget.email
            ? TextInputType.emailAddress
            : TextInputType.visiblePassword,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(20),
            hintStyle: myTextStyle(14, MyColors.hint, null),
            hintText: widget.hint,
            fillColor: MyColors.background,
            filled: true,
            suffixIcon: widget.email == true
                ? null
                : IconButton(
                    icon: Icon(
                        isRevealed ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        log("clicked");
                        isRevealed = !isRevealed;
                      });
                    },
                  ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none)));
  }
}
