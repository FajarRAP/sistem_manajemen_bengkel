import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/common/widgets/home_app_bar.dart';
import '../../core/common/widgets/home_content.dart';
import '../../core/common/widgets/home_content_title.dart';
import '../../core/common/widgets/snackbar_error.dart';
import '../../core/common/widgets/snackbar_success.dart';
import '../../core/constants_finals.dart';
import '../auth/presentation/cubit/auth_cubit.dart';
import '../queue/domain/usecases/pick_queue_use_case.dart';
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
          queueCubit.getQueueNumToday();
          errorSnackBar(context, state.message);
        }
        if (state is PickQueueSuccess) {
          queueCubit.getQueueNumToday();
          successSnackBar(context, state.message);
        }
        if (state is QueueNotAccepted) {
          queueCubit.getMyQueueToday(authCubit.getUsername);
          queueCubit.getQueueNumToday();
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
              const HomeAppBar(),
              Positioned(
                top: 170,
                left: 0,
                right: 0,
                child: HomeContent(
                  height: 210,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const HomeContentTitle(
                        title: 'Ambil Antrianmu',
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
                                      color: Colors.white),
                                );
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
