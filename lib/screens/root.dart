import 'dart:convert';

import 'package:animu/screens/login/login.dart';
import 'package:animu/screens/wrapper/wrapper.dart';
import 'package:animu/shared/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  final storage = FlutterSecureStorage();
  bool showLogin = true;
  bool isLoading = true;
  String finalToken = '';

  @override
  void initState() {
    super.initState();
    checkLoginState();
  }

  void checkLoginState() async {
    final String token = await storage.read(key: 'auth_token');

    if (token != null) {
      final http.Response resRaw =
          await http.get('$serverAddress/api/auth?token=$token');

      final Map res = jsonDecode(resRaw.body);

      if (!res.containsKey('guildID')) {
        // Invalid Token
        clearToken();
      } else {
        setState(() {
          isLoading = false;
          finalToken = token;
          showLogin = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  void setToken(token) async {
    await storage.write(key: 'auth_token', value: token);
    setState(() {
      finalToken = token;
      isLoading = false;
      showLogin = false;
    });
  }

  void clearToken() async {
    await storage.delete(key: 'auth_token');
    setState(() {
      showLogin = true;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            color: Colors.white,
            padding: const EdgeInsets.all(40.0),
            child: Center(
              child: Image.asset('assets/login_logo.png'),
            ),
          )
        : showLogin
            ? Login(setToken: setToken)
            : Wrapper(token: finalToken, clearToken: clearToken);
  }
}
