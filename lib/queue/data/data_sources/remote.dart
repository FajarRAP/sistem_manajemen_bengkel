import 'package:bengkel_pak_bowo/core/constants_finals.dart';
import 'package:http/http.dart';

class QueueService {
  Future<Response> getQueueToday() async =>
      await get(Uri.parse('$url${endpoint['queue']}'), headers: headers);

  Future<Response> pickQueue(
          final Map<String, String> headers, final String body) async =>
      await post(Uri.parse('$url${endpoint['queue']}'),
          headers: headers, body: body);

  Future<Response> getQueueNumToday() async =>
      await get(Uri.parse('$url${endpoint['queueNum']}'), headers: headers);

  Future<Response> getMyQueueToday(final Map<String, String> headers, final String username) async =>
      await get(Uri.parse('$url${endpoint['queueMe']}/$username'),
          headers: headers);
}
