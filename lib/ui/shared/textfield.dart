// ignore_for_file: prefer_const_constructors

import 'package:ceos/utils/color.dart';
import 'package:ceos/utils/font_size.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final Function? onChanged;
  final TextEditingController controller;
  final String? errorText;
  final bool? obscureText;
  final bool? isEnabled;
  final IconData? prefix;

  // ignore: use_key_in_widget_constructors
  const CustomTextField(
      {required this.hintText,
      this.prefix,
      this.labelText,
      this.onChanged,
      required this.controller,
      this.errorText,
      this.obscureText,
      this.isEnabled});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.only(top: 5.0),
        width: MediaQuery.of(context).size.width / 1.1,
        child: TextFormField(
          onChanged: (text) {
            if (widget.onChanged != null) {
              widget.onChanged!(text);
            }
          },
          controller: widget.controller,
          style: GoogleFonts.lato(
              color: ceoBlack,
              fontSize: TextSize().p(context),
              fontWeight: FontWeight.w500),
          enabled: widget.isEnabled,
          decoration: InputDecoration(
            filled: true,
            fillColor: greyOne,
            prefixIcon: widget.prefix != null
                ? Icon(
                    widget.prefix,
                    color: ceoPurpleGrey,
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: GoogleFonts.lato(
                color: ceoPurpleGrey,
                fontSize: TextSize().p(context),
                fontWeight: FontWeight.w500),
            labelText: widget.labelText,
            labelStyle: GoogleFonts.lato(
                color: ceoPurpleGrey,
                fontSize: TextSize().p(context),
                fontWeight: FontWeight.w500),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(width: 2.5, color: greyOne!)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(width: 2, color: greyOne!)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(width: 2, color: greyOne!)),
            errorText: widget.errorText,
          ),
          obscureText: widget.obscureText == null ? false : true,
          obscuringCharacter: '*',
        ),
      ),
    );
  }
}
