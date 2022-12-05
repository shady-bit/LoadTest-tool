import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RunButton extends StatelessWidget {
  final VoidCallback? onPress;
  const RunButton({
    @required this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0), topRight: Radius.circular(0))),
            backgroundColor: Colors.green,
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              Icons.start,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "RUN",
              style:
                  GoogleFonts.sourceCodePro(fontSize: 17, color: Colors.white),
            ),
          ])),
    );
  }
}