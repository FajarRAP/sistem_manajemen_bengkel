import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemJasa extends StatelessWidget {
  final String src;
  final String title;
  const ItemJasa({
    super.key,
    required this.src,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: const Color(0xFFD9D9D9),
          ),
          padding: const EdgeInsets.all(16),
          child: Image.asset('assets/icons/$src', scale: 1.5),
        ),
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
              fontSize: 10, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
