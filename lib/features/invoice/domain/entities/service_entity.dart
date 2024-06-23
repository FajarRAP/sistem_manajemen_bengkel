import 'package:intl/intl.dart';

class Service {
  final String name;
  final int price;

  String get formattedTotalHarga => NumberFormat('###,###').format(price);

  Service({
    required this.name,
    required this.price,
  });
}
