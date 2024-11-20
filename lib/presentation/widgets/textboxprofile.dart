import 'dart:developer';

import 'package:flutter/material.dart';

class TextBoxProfile extends StatefulWidget {
  const TextBoxProfile(
      {super.key,
      required this.hint,
      required this.textinputtype,
      required this.controller});

  final String hint;
  final TextEditingController? controller;
  final TextInputType textinputtype;
  @override
  State<TextBoxProfile> createState() => _TextBoxProfileState();
}

bool isRevealed = false;

class _TextBoxProfileState extends State<TextBoxProfile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.textinputtype,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20),
          hintStyle: TextStyle(color: Colors.grey[400]),
          hintText: widget.hint,
          fillColor: Colors.black.withOpacity(0.05),
          filled: true,
          suffixIcon: widget.controller!.text.isEmpty
              ? null
              : Icon(Icons.confirmation_num),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
