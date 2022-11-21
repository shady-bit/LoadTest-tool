import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IncidentSequenceWidget extends StatelessWidget {
  const IncidentSequenceWidget({
    Key? key,
    required this.incidentSequence,
  }) : super(key: key);

  final String incidentSequence;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
          color: Colors.grey.shade900, borderRadius: BorderRadius.circular(6)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Incident Sequence",
          style: GoogleFonts.sourceCodePro(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: const Color(0xffc7ecee)),
        ),
        Text(
          incidentSequence,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        )
      ]),
    );
  }
}