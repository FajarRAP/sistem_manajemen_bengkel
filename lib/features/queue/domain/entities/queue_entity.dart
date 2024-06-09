import 'package:intl/intl.dart';

class QueueEntity {
  String get getDate => DateFormat('d MMMM y').format(issuedAt);
  String get getTime => DateFormat('HH:mm').format(issuedAt);

  final int queueNum;
  final String username;
  final String name;
  final DateTime issuedAt;

  QueueEntity({
    required this.queueNum,
    required this.username,
    required this.name,
    required this.issuedAt,
  });
}
