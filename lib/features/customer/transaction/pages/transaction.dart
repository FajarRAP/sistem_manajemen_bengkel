import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(40),
              ),
              color: color.primary,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            width: double.infinity,
            height: 230,
            child: Align(
              alignment: const Alignment(0, -.6),
              child: Text(
                'Daftar Transaksi',
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
