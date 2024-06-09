import '../../../../core/constants_finals.dart';
import 'package:http/http.dart';

abstract interface class AuthRemoteDataSource {
  Future<Response> authLogin(final String body);
  Future<Response> authRegister(final String body);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<Response> authLogin(final String body) async =>
      await post(Uri.parse('$url${endpoint['login']}'),
          headers: headers, body: body);

  @override
  Future<Response> authRegister(final String body) async =>
      await post(Uri.parse('$url${endpoint['register']}'),
          headers: headers, body: body);
}
