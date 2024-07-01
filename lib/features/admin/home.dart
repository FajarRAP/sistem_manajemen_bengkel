import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/common/widgets/home_app_bar.dart';
import '../../core/common/widgets/home_content.dart';
import '../../core/common/widgets/home_content_title.dart';
import '../queue/presentation/cubit/queue_cubit.dart';
import 'widgets/item_queue.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                height: 575,
                child: LayoutBuilder(
                  builder: (context, constraints) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HomeContentTitle(
                        title: 'Antrian Hari Ini',
                      ),
                      const Gap(12),
                      RefreshIndicator(
                        displacement: 10,
                        onRefresh: () async =>
                            context.read<QueueCubit>().getQueueToday(),
                        child: SizedBox(
                          height: constraints.maxHeight - 45,
                          child: BlocBuilder<QueueCubit, QueueState>(
                            bloc: context.read<QueueCubit>()..getQueueToday(),
                            buildWhen: (previous, current) =>
                                current is QueueToday,
                            builder: (context, state) {
                              if (state is QueueTodayLoading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (state is QueueTodayLoaded) {
                                return ListView.separated(
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return ItemQueue(queue: state.datas[index]);
                                  },
                                  separatorBuilder: (context, index) =>
                                      const Gap(12),
                                  itemCount: state.datas.length,
                                );
                              }
                              if (state is QueueTodayEmpty) {
                                return Center(
                                  child: Text(
                                    'Belum Ada Antrian',
                                    style: GoogleFonts.plusJakartaSans(
                                        fontWeight: FontWeight.w600),
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
