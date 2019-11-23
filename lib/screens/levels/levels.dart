import 'dart:convert';

import 'package:animu/screens/levels/level_leaderboards.dart';
import 'package:animu/screens/levels/level_perks.dart';
import 'package:animu/screens/levels/level_settings.dart';
import 'package:animu/shared/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class Levels extends StatefulWidget {
  final String token;
  Levels({this.token});

  @override
  _LevelsState createState() => _LevelsState();
}

class _LevelsState extends State<Levels> {
  bool isLoading = true;
  bool areLevelsOn = true;

  @override
  void initState() {
    super.initState();
    fetchInitialState();
  }

  void fetchInitialState() async {
    final http.Response resRaw =
        await http.get('$serverAddress/api/settings?token=${widget.token}');

    final Map res = jsonDecode(resRaw.body);

    setState(() {
      areLevelsOn = res['settings']['enableLevels'];
      isLoading = false;
    });
  }

  void toggleLevels(val) async {
    final Map<String, dynamic> data = {'key': 'enableLevels', 'value': val};

    final body = jsonEncode(data);

    final http.Response resRaw = await http.post(
        '$serverAddress/api/settings?token=${widget.token}',
        headers: {"Content-Type": "application/json"},
        body: body);
    final Map res = jsonDecode(resRaw.body);

    setState(() {
      areLevelsOn = res['settings']['enableLevels'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        color: Colors.white,
        child: Center(
          child: isLoading
              ? SpinKitRotatingCircle(
                  color: Colors.blue,
                  size: 50.0,
                )
              : Scaffold(
                  resizeToAvoidBottomInset: false,
                  resizeToAvoidBottomPadding: false,
                  appBar: AppBar(
                    title: Text(
                      'Levels',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    actions: <Widget>[
                      Switch(
                        onChanged: (val) {
                          setState(() {
                            toggleLevels(val);
                          });
                        },
                        value: areLevelsOn,
                      )
                    ],
                    bottom: TabBar(
                      tabs: <Widget>[
                        Tab(
                          icon: Icon(Icons.show_chart, color: Colors.black),
                        ),
                        Tab(
                          icon: Icon(Icons.settings, color: Colors.black),
                        ),
                        Tab(
                          icon: Icon(Icons.star, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: <Widget>[
                      !areLevelsOn
                          ? Center(
                              child: Text('Enable Levels to view Leaderboards'),
                            )
                          : LevelLeaderboards(
                              token: widget.token,
                            ),
                      !areLevelsOn
                          ? Center(
                              child: Text('Enable Levels to view Settings'),
                            )
                          : LevelSettings(
                              token: widget.token,
                            ),
                      !areLevelsOn
                          ? Center(
                              child: Text('Enable Levels to view Level Perks'),
                            )
                          : LevelPerks(
                              token: widget.token,
                            ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
