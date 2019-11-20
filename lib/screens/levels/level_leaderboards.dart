import 'dart:convert';

import 'package:animu/models/level_leaderboards_user.dart';
import 'package:animu/shared/config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LevelLeaderboards extends StatefulWidget {
  final String token;
  LevelLeaderboards({this.token});

  @override
  _LevelLeaderboardsState createState() => _LevelLeaderboardsState();
}

class _LevelLeaderboardsState extends State<LevelLeaderboards> {
  bool isLoading = true;

  List<LevelLeaderboardsUser> users = [];

  @override
  void initState() {
    super.initState();
    fetchLeaderboards();
  }

  void fetchLeaderboards() async {
    final http.Response resRaw = await http
        .get('$serverAddress/api/leaderboards/levels?token=${widget.token}');

    final Map res = jsonDecode(resRaw.body);

    if (mounted)
      setState(() {
        isLoading = false;

        for (var i = 0; i < res['members'].length; i++) {
          users.add(
            LevelLeaderboardsUser(
              avatarUrl: res['members'][i]['avatarURL'],
              username: res['members'][i]['username'],
              level: res['members'][i]['level'],
            ),
          );
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SpinKitRotatingCircle(
            color: Colors.blue,
            size: 50.0,
          )
        : Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            leading: SizedBox(
                              width: 70.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${(i + 1).toString()}. ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  if (i < 9)
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(users[i].avatarUrl),
                                  ),
                                ],
                              ),
                            ),
                            title: Text(
                              users[i].username.length > 20
                                  ? '${users[i].username.substring(0, 20)}...'
                                  : users[i].username,
                            ),
                            trailing: Text(
                              users[i].level.toString(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Divider(),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          );
  }
}
