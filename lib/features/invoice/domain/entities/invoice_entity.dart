import 'customer_entity.dart';
import 'service_entity.dart';

class Invoice {
  final int queueNum;
  final Customer customer;
  final Service service;
  final DateTime boughtAt;

  Invoice({
    required this.queueNum,
    required this.customer,
    required this.service,
    required this.boughtAt,
  });
}
