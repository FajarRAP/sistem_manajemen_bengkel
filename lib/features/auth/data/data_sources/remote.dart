import 'package:bengkel_pak_bowo/core/constants_finals.dart';
import 'package:http/http.dart';

class AuthService {
  Future<Response> authLogin(final String body) async {
    return await post(
      Uri.parse('$url${endpoint['login']}'),
      headers: headers,
      body: body,
    );
  }

  Future<Response> authRegister(final String body) async {
    return await post(
      Uri.parse('$url${endpoint['register']}'),
      headers: headers,
      body: body,
    );
  }
}
