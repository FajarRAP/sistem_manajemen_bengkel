import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> successSnackBar(
        BuildContext context, final String message) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green.shade800,
        content: Text(
          message,
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
