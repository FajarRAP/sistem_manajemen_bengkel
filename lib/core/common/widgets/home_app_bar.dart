import 'package:bengkel_pak_bowo/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final color = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(40),
        ),
        color: color.primary,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: 230,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selamat Datang,',
            style: GoogleFonts.plusJakartaSans(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
          ),
          Text(
            authCubit.getName,
            style: GoogleFonts.plusJakartaSans(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
