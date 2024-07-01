import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeContentTitle extends StatelessWidget {
  const HomeContentTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.plusJakartaSans(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
