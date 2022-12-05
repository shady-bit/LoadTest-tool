import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetStyles{
  static InputDecoration textFieldDecor(String lableText) {
    return InputDecoration(
        hintText: lableText,
        hintStyle: GoogleFonts.sourceCodePro(fontSize: 13, color: Colors.white),
        filled: true,
        fillColor: Color(0xff2f3640),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            gapPadding: 0.0));
  }
}