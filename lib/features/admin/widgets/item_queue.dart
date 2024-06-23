import '../../../core/constants_finals.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../queue/domain/entities/queue_entity.dart';

class ItemQueue extends StatelessWidget {
  const ItemQueue({
    super.key,
    required this.queue,
  });

  final QueueEntity queue;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => !queue.isAccepted
          ? Navigator.pushNamed(context, makeInvoicePage)
          : null,
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
                  color: color.primary,
                  borderRadius: BorderRadius.circular(30)),
              width: 40,
              height: 40,
              child: Center(
                child: queue.isAccepted
                    ? Icon(Icons.check, color: color.secondary)
                    : Text(
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
      ),
    );
  }
}
