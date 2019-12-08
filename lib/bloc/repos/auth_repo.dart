import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  static const baseUrl = 'http://140.82.39.61:8080'; // Public
      // 'http://192.168.1.105:8080'; // Dev testing

  final storage = FlutterSecureStorage();

  Future<dynamic> authenticate({@required String token}) async {
    final http.Response resRaw =
        await http.get('$baseUrl/api/auth?token=$token');

    final Map res = jsonDecode(resRaw.body);

    if (!res.containsKey('guildID'))
      return false;
    else {
      return true;
    }
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'auth_token');
    return;
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: 'auth_token', value: token);
    return;
  }

  Future<String> getToken() async {
    final String token = await storage.read(key: 'auth_token');
    return token;
  }

  Future<bool> hasToken() async {
    final String token = await storage.read(key: 'auth_token');
    if (token == null)
      return false;
    else
      return true;
  }
}
