import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:flutter/material.dart';

class TextBoxProfile extends StatefulWidget {
  const TextBoxProfile(
      {super.key,
      required this.hint,
      required this.textinputtype,
      required this.controller,
      required this.isEditable});

  final String hint;
  final TextEditingController? controller;
  final TextInputType textinputtype;
  final bool isEditable;
  @override
  State<TextBoxProfile> createState() => _TextBoxProfileState();
}

class _TextBoxProfileState extends State<TextBoxProfile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.textinputtype,
        readOnly: !widget.isEditable,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20),
          hintStyle: myTextStyle(14, MyColors.hint, null),
          hintText: widget.hint,
          fillColor: MyColors.block,
          filled: true,
          suffixIcon: (widget.controller!.text.isEmpty || !widget.isEditable)
              ? null
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/confirm_field.png',
                    fit: BoxFit.contain,
                  ),
                ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
