import 'dart:convert';

import 'package:bengkel_pak_bowo/queue/domain/entities/queue_entity.dart';

List<QueueModel> queueFromJson(final String str) =>
    (jsonDecode(str)["datas"] as List)
        .map((e) => QueueModel.fromJson(e))
        .toList();

class QueueModel extends QueueEntity {
  QueueModel({
    required super.queueNum,
    required super.username,
    required super.issuedAt,
  });

  factory QueueModel.fromJson(final Map<String, dynamic> json) => QueueModel(
      queueNum: json["queue_no"],
      username: json["username"],
      issuedAt: DateTime.parse(json["issued_at"]));

  Map<String, dynamic> toJson() => {
        "queue_no": queueNum,
        "username": username,
        "issued_at": issuedAt,
      };
}
