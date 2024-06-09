import 'package:bengkel_pak_bowo/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bengkel_pak_bowo/features/queue/presentation/cubit/queue_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class QueuePage extends StatelessWidget {
  const QueuePage({super.key});

  @override
  Widget build(BuildContext context) {
    final queueCubit = context.read<QueueCubit>();
    final color = Theme.of(context).colorScheme;

    return BlocListener<QueueCubit, QueueState>(
      bloc: queueCubit,
      listener: (context, state) {
        print(state);
      },
      child: Scaffold(
        body: Container(
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
              ),
              Positioned(
                top: 50,
                right: 0,
                left: 0,
                child: Text(
                  'Tiket Antrian',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Positioned(
                top: 125,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 0,
                          offset: const Offset(0, 1),
                          color: Colors.black.withOpacity(.1)),
                      BoxShadow(
                          blurRadius: 5,
                          spreadRadius: 0,
                          offset: const Offset(0, 5),
                          color: Colors.black.withOpacity(.09)),
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  margin: const EdgeInsets.symmetric(horizontal: 28),
                  height: 300,
                  child: Column(
                    children: [
                      Text(
                        'Bengkel Bowo',
                        style: GoogleFonts.plusJakartaSans(
                            color: color.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                      const Gap(50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.read<AuthCubit>().getName,
                            style: GoogleFonts.plusJakartaSans(
                                fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          BlocBuilder<QueueCubit, QueueState>(
                            buildWhen: (previous, current) =>
                                current is MyQueueToday,
                            builder: (context, state) {
                              if (state is MyQueueTodayLoaded) {
                                return Text(
                                  DateFormat("d MMMM y")
                                      .format(state.data.issuedAt),
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                );
                              }
                              return Text(
                                '...',
                                style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              );
                            },
                          ),
                        ],
                      ),
                      const Gap(18),
                      const Divider(),
                      const Gap(44),
                      Container(
                        color: const Color(0xFF88AAF1).withOpacity(.4),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Antrian',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            BlocBuilder<QueueCubit, QueueState>(
                              buildWhen: (previous, current) =>
                                  current is MyQueueToday,
                              builder: (context, state) {
                                if (state is MyQueueTodayLoaded) {
                                  return Text(
                                    '${state.data.queueNum}',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  );
                                }
                                return Text(
                                  '...',
                                  style: GoogleFonts.plusJakartaSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                );
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
