import 'dart:convert';

import 'package:animu/shared/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:http/http.dart' as http;
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class Login extends StatefulWidget {
  final Function setToken;
  final signOut;
  Login({this.setToken, this.signOut});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final storage = FlutterSecureStorage();

  String msg = 'Enter your Animu Token to continue';
  Color msgColor = Colors.grey;
  String token = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Stack(
                children: <Widget>[
                  WavyHeader(),
                  Container(
                    margin: EdgeInsets.fromLTRB(70.0, 100.0, 20.0, 0),
                    child: Image.asset('assets/login_logo.png'),
                  ),
                ],
              ),
            ),
            flex: 3,
          ),
          Expanded(
            child: Container(
              width: 300.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 30.0,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Animu Token',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[400],
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: <Widget>[
                      Material(
                        elevation: 10.0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 40.0,
                            right: 20.0,
                            top: 10.0,
                            bottom: 10.0,
                          ),
                          child: TextField(
                            onChanged: (val) => token = val,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "XXXXXXXXXXXXXXXX",
                              hintStyle: TextStyle(
                                color: Color(0xFFE1E1E1),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 125.0,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 35, 15, 0),
                                  child: Text(
                                    msg,
                                    style: TextStyle(
                                      color: msgColor,
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ),
                              ),
                              CircularGradientButton(
                                child: Icon(Icons.arrow_forward),
                                callback: () async {
                                  if (token.isEmpty)
                                    return setState(() {
                                      msg =
                                          'Please provide Animu token to proceed';
                                      msgColor = Colors.red;
                                    });

                                  final http.Response resRaw = await http.get(
                                      '$serverAddress/api/auth?token=$token');

                                  final Map res = jsonDecode(resRaw.body);

                                  if (!res.containsKey('guildID'))
                                    return setState(() {
                                      msg = 'Invalid token';
                                      msgColor = Colors.red;
                                    });

                                  setState(() {
                                    msg = 'Logging In';
                                    msgColor = Colors.grey;
                                  });

                                  widget.setToken(token);
                                },
                                gradient: Gradients.cosmicFusion,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: Container(
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [Colors.blue[100], Colors.blue[300]],
                    [Colors.blue[400], Colors.blue[500]],
                    [Colors.blue[600], Colors.blue[700]],
                    [Colors.blue[500], Colors.blue[900]],
                  ],
                  durations: [35000, 19440, 10800, 6000],
                  heightPercentages: [0.20, 0.23, 0.25, 0.30],
                  blur: MaskFilter.blur(BlurStyle.solid, 10),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                duration: 32000,
                waveAmplitude: 0,
                heightPercentange: 0.25,
                size: Size(
                  double.infinity,
                  double.infinity,
                ),
              ),
            ),
            flex: 2,
          )
        ],
      ),
    );
  }
}

class WavyHeader extends StatelessWidget {
  final List<Color> orangeGradients = [
    Colors.blue[200],
    Colors.blue,
    Colors.blue[700],
  ];

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopWaveClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: orangeGradients,
              begin: Alignment.topLeft,
              end: Alignment.center),
        ),
        height: MediaQuery.of(context).size.height / 2.5,
      ),
    );
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // This is where we decide what part of our image is going to be visible.
    var path = Path();
    path.lineTo(0.0, size.height);

    //creating first curver near bottom left corner
    var firstControlPoint = new Offset(size.width / 7, size.height - 30);
    var firstEndPoint = new Offset(size.width / 6, size.height / 1.5);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    //creating second curver near center
    var secondControlPoint = Offset(size.width / 5, size.height / 4);
    var secondEndPoint = Offset(size.width / 1.5, size.height / 5);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    //creating third curver near top right corner
    var thirdControlPoint =
        Offset(size.width - (size.width / 9), size.height / 6);
    var thirdEndPoint = Offset(size.width, 0.0);

    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    ///move to top right corner
    path.lineTo(size.width, 0.0);

    ///finally close the path by reaching start point from top right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
