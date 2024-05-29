import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopSection extends StatelessWidget {
  const TopSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/login.png'),
        Positioned(
          top: 110,
          left: 20,
          child: Text(
            'SELAMAT DATANG',
            style: GoogleFonts.plusJakartaSans(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.w800),
          ),
        ),
        Positioned(
          top: 150,
          left: 20,
          child: Text(
            'di Bengkel Bowo!',
            style: GoogleFonts.plusJakartaSans(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
