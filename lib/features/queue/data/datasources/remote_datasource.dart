import '../../../../core/constants_finals.dart';
import 'package:http/http.dart';

abstract interface class QueueRemoteDataSource {
  Future<Response> getQueueToday();
  Future<Response> pickQueue(final String body);
  Future<Response> getQueueNumToday();
  Future<Response> getMyQueueToday(final String username);
}

class QueueRemoteDataSourceImpl implements QueueRemoteDataSource {
  @override
  Future<Response> getQueueToday() async =>
      await get(Uri.parse('$url${endpoint['queue']}'), headers: headers);

  @override
  Future<Response> pickQueue(final String body) async =>
      await post(Uri.parse('$url${endpoint['queue']}'),
          body: body, headers: headers);

  @override
  Future<Response> getQueueNumToday() async =>
      await get(Uri.parse('$url${endpoint['queueNum']}'), headers: headers);

  @override
  Future<Response> getMyQueueToday(final String username) async =>
      await get(Uri.parse('$url${endpoint['queueMe']}/$username'),
          headers: headers);
}
