import 'dart:convert';

import '../../domain/entities/queue_entity.dart';

List<QueueModel> queuesFromJson(final String str) =>
    (jsonDecode(str)["datas"] as List)
        .map((e) => QueueModel.fromJson(e))
        .toList();
QueueModel queueFromJson(final String str) =>
    QueueModel.fromJson(jsonDecode(str)['data']);

class QueueModel extends QueueEntity {
  QueueModel({
    required super.queueNum,
    required super.username,
    required super.name,
    required super.isAccepted,
    required super.issuedAt,
  });

  factory QueueModel.fromJson(final Map<String, dynamic> json) => QueueModel(
      queueNum: json["queue_no"],
      username: json["username"],
      name: json["name"],
      isAccepted: json["accepted"],
      issuedAt: DateTime.parse(json["issued_at"]));

  Map<String, dynamic> toJson() => {
        "queue_no": queueNum,
        "username": username,
        "name": name,
        "accepted": isAccepted,
        "issued_at": issuedAt,
      };
}
