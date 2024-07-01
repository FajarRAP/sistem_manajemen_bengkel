import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileContentTitle extends StatelessWidget {
  const ProfileContentTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$title Bulan : ',
      style: GoogleFonts.plusJakartaSans(
        color: const Color(0xFF464646),
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
