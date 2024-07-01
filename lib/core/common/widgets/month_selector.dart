import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MonthSelector extends StatelessWidget {
  const MonthSelector({
    super.key,
    required this.month,
    required this.increment,
    required this.decrement,
  });

  final int month;
  final void Function() increment;
  final void Function() decrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: const Color(0xFFEEEEEE),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 40),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: decrement,
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          Text(
            DateFormat('MMMM').format(DateTime(DateTime.now().year, month)),
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            onPressed: increment,
            icon: const Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }
}

