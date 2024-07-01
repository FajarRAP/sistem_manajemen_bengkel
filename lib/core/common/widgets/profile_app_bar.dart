import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../features/auth/presentation/cubit/auth_cubit.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfileAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final authCubit = context.read<AuthCubit>();
    
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: color.primary,
      title: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text(
              'Profile',
              style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            const Gap(18),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              margin: const EdgeInsets.symmetric(horizontal: 40),
              padding: const EdgeInsets.symmetric(
                horizontal: 26,
                vertical: 13,
              ),
              width: double.infinity,
              child: Text(
                authCubit.getName,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 18, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      toolbarHeight: 150,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
