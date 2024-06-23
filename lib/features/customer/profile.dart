import 'package:bengkel_pak_bowo/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/presentation/cubit/auth_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final authCubit = context.read<AuthCubit>();
    final invoiceCubit = context.read<InvoiceCubit>();

    return Scaffold(
      appBar: AppBar(
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 7,
                    spreadRadius: 1,
                    color: Colors.black.withOpacity(.25),
                  ),
                ],
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 24),
              width: double.infinity,
              height: 480,
              child: BlocBuilder<InvoiceCubit, InvoiceState>(
                builder: (context, state) {
                  print(invoiceCubit.invoice);
                  return Text('bokep');
                },
              ),
            ),
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => authCubit.authLogout(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFA0C0C),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text(
                  'Logout',
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
