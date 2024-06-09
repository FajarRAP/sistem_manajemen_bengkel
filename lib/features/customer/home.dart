import 'package:bengkel_pak_bowo/core/common/widgets/snackbar_error.dart';
import 'package:bengkel_pak_bowo/core/common/widgets/snackbar_success.dart';
import 'package:bengkel_pak_bowo/features/queue/domain/usecases/pick_queue_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants_finals.dart';
import '../auth/presentation/cubit/auth_cubit.dart';
import '../queue/presentation/cubit/queue_cubit.dart';
import 'widgets/item_jasa.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final queueCubit = context.read<QueueCubit>();
    final color = Theme.of(context).colorScheme;

    return BlocListener<QueueCubit, QueueState>(
      listener: (context, state) {
        if (state is PickQueueError) {
          errorSnackBar(context, state.message);
        }
        if (state is PickQueueSuccess) {
          successSnackBar(context, state.message);
        }
        if (state is QueueNotAccepted) {
          queueCubit.getMyQueueToday(authCubit.getUsername);
          Navigator.pushNamed(context, queuePage);
        }
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang,',
                      style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      authCubit.credentials['name'] ?? 'Default',
                      style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 170,
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
                  margin: const EdgeInsets.symmetric(horizontal: 28),
                  height: 210,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Ambil Antrianmu',
                          style: GoogleFonts.plusJakartaSans(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const Gap(12),
                        InkWell(
                          onTap: () => queueCubit.pickQueue(PickQueueParams(
                              authCubit.getUsername, authCubit.getName)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: color.primary,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            width: double.infinity,
                            height: 50,
                            child: BlocBuilder<QueueCubit, QueueState>(
                              buildWhen: (previous, current) =>
                                  current is PickQueue,
                              builder: (context, state) {
                                if (state is PickQueueLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.white));
                                }
                                return Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Ambil',
                                        style: GoogleFonts.plusJakartaSans(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Icon(Icons.arrow_forward,
                                          color: color.secondary),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        const Gap(40),
                        Row(
                          children: [
                            Text(
                              'Antrian saat ini :',
                              style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const Gap(10),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: color.primary,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 4),
                              child: Row(
                                children: [
                                  const Icon(CupertinoIcons.timer,
                                      color: Colors.white),
                                  const Gap(12),
                                  BlocBuilder<QueueCubit, QueueState>(
                                    bloc: queueCubit..getQueueNumToday(),
                                    buildWhen: (previous, current) =>
                                        current is QueueNumToday,
                                    builder: (context, state) {
                                      if (state is QueueNumTodayLoaded) {
                                        return Text(
                                          '${state.queueNum}',
                                          style: GoogleFonts.plusJakartaSans(
                                              color: color.secondary,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800),
                                        );
                                      }
                                      return Text(
                                        '...',
                                        style: GoogleFonts.plusJakartaSans(
                                            color: color.secondary,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 400,
                left: 16,
                child: Text(
                  'Jasa Yang Ditawarkan',
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const Positioned(
                bottom: 185,
                left: 24,
                right: 24,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ItemJasa(src: 'ac.png', title: 'Service AC'),
                        ItemJasa(src: 'cat_body.png', title: 'Cat Full Body'),
                        ItemJasa(src: 'tune_up.png', title: 'Tune Up'),
                        ItemJasa(src: 'kampas.png', title: 'Service Kampas'),
                      ],
                    ),
                    Gap(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ItemJasa(src: 'poles.png', title: 'Poles'),
                        ItemJasa(src: 'cat_panel.png', title: 'Cat Panel'),
                        ItemJasa(src: 'modif.png', title: 'Modifikasi'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
