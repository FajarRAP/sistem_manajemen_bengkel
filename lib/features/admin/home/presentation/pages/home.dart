import 'package:bengkel_pak_bowo/features/customer/home/presentation/cubit/queue_cubit.dart';
import 'package:bengkel_pak_bowo/queue/domain/entities/queue_entity.dart';

import '../../../../../core/constants_finals.dart';
import '../../../transaction/data/models/invoice.dart';
import '../../../transaction/presentation/cubit/invoice_cubit.dart';
import '../../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../../../injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final color = Theme.of(context).colorScheme;
    final token = locator<SharedPreferences>().getString('token');
    if (token != null) {
      authCubit.credentials = JwtDecoder.decode(token);
    }

    return Scaffold(
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
                height: 140,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Tambah Invoice',
                        style: GoogleFonts.plusJakartaSans(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      const Gap(12),
                      InkWell(
                        onTap: () =>
                            Navigator.of(context).pushNamed(makeInvoicePage),
                        // onTap: () => context.read<QueueCubit>().getQueueToday(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: color.primary,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          width: double.infinity,
                          height: 50,
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Tambah',
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 340,
              left: 16,
              child: Text(
                'Antrian Hari Ini',
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Positioned(
              top: 380,
              left: 24,
              right: 24,
              child: RefreshIndicator(
                displacement: 10,
                onRefresh: () async =>
                    context.read<QueueCubit>().getQueueToday(),
                child: SizedBox(
                  height: 375,
                  child: BlocBuilder<QueueCubit, QueueState>(
                    bloc: context.read<QueueCubit>()..getQueueToday(),
                    builder: (context, state) {
                      if (state is QueueTodayLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is QueueTodayLoaded) {
                        return ListView.separated(
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) =>
                              ItemQueue(queue: state.datas[index]),
                          separatorBuilder: (context, index) => const Gap(12),
                          itemCount: state.datas.length,
                        );
                      }
                      return const SizedBox();
                    },
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

class ItemQueue extends StatelessWidget {
  const ItemQueue({
    super.key,
    required this.queue,
  });

  final QueueEntity queue;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0).withOpacity(.4),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                queue.username,
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Text(
                    queue.getDate,
                    style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFF555555),
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                  const Gap(6),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(7)),
                    height: 7,
                    width: 7,
                  ),
                  const Gap(6),
                  Text(
                    queue.getTime,
                    style: GoogleFonts.plusJakartaSans(
                        color: const Color(0xFF555555),
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                color: color.primary, borderRadius: BorderRadius.circular(30)),
            width: 40,
            height: 40,
            child: Center(
              child: Text(
                '${queue.queueNum}',
                style: GoogleFonts.plusJakartaSans(
                    color: color.secondary,
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

class ItemTransaksi extends StatelessWidget {
  const ItemTransaksi({
    super.key,
    required this.invoice,
  });

  final InvoiceModel invoice;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        context.read<InvoiceCubit>().invoice = invoice;
        Navigator.pushNamed(context, detailInvoicePage);
      },
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0).withOpacity(.4),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: double.infinity,
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  invoice.namaPelanggan,
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      invoice.getDate,
                      style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF555555),
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    const Gap(6),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(7)),
                      height: 7,
                      width: 7,
                    ),
                    const Gap(6),
                    Text(
                      invoice.getTime,
                      style: GoogleFonts.plusJakartaSans(
                          color: const Color(0xFF555555),
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
