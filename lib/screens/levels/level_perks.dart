import 'dart:convert';

import 'package:animu/models/level_perk.dart';
import 'package:animu/models/role.dart';
import 'package:animu/shared/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class LevelPerks extends StatefulWidget {
  final String token;
  LevelPerks({this.token});

  @override
  _LevelPerksState createState() => _LevelPerksState();
}

class _LevelPerksState extends State<LevelPerks> {
  bool isLoading = true;

  List<LevelPerk> levelPerks = [];
  List<Role> roles = [];

  // Fields
  int level;
  String badge;
  Role role;
  int rep;

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  void fetchInitialData() async {
    final List<http.Response> dataRaw = await Future.wait(
      [
        http.get('$serverAddress/api/roles?token=${widget.token}'),
        http.get('$serverAddress/api/levelperks?token=${widget.token}'),
      ],
    );

    final List data = dataRaw.map((d) => jsonDecode(d.body)).toList();

    final Map rolesFetched = data[0];
    final Map levelPerksFetched = data[1];

    if (mounted)
      setState(() {
        isLoading = false;

        for (var i = 0; i < levelPerksFetched['levelPerks'].length; i++) {
          levelPerks.add(
            LevelPerk(
              level: levelPerksFetched['levelPerks'][i]['level'],
              badge: levelPerksFetched['levelPerks'][i]['badge'],
              rep: levelPerksFetched['levelPerks'][i]['rep'],
              role: levelPerksFetched['levelPerks'][i]['role'],
            ),
          );
        }

        for (var i = 0; i < rolesFetched['roles'].length; i++) {
          roles.add(
            Role(
              id: rolesFetched['roles'][i]['id'],
              name: rolesFetched['roles'][i]['name'],
            ),
          );
        }
      });
  }

  void createPerk(level, key, value) async {
    final Map<String, dynamic> data = {
      'level': level,
      'perkName': key,
      'perkValue': value
    };

    final body = jsonEncode(data);

    final http.Response resRaw = await http.post(
        '$serverAddress/api/levelperks?token=${widget.token}',
        headers: {"Content-Type": "application/json"},
        body: body);

    final Map res = jsonDecode(resRaw.body);

    setState(() {
      level = null;
      badge = null;
      rep = null;
      role = null;

      levelPerks.clear();

      for (var i = 0; i < res['levelPerks'].length; i++) {
        levelPerks.add(
          LevelPerk(
            level: res['levelPerks'][i]['level'],
            badge: res['levelPerks'][i]['badge'],
            rep: res['levelPerks'][i]['rep'],
            role: res['levelPerks'][i]['role'],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? SpinKitRotatingCircle(
              color: Colors.blue,
              size: 50.0,
            )
          : Container(
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: levelPerks.length,
                  itemBuilder: (BuildContext context, int i) {
                    String subtitle = '';
                    if (levelPerks[i].role != null)
                      subtitle += 'Role: ${levelPerks[i].role}';

                    if (levelPerks[i].badge != null)
                      subtitle += 'Badge: ${levelPerks[i].badge}';

                    if (levelPerks[i].rep != null)
                      subtitle += 'Rep: ${levelPerks[i].rep}';

                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(
                              (i + 1).toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          title:
                              Text('Level ${levelPerks[i].level.toString()}'),
                          subtitle: Text(subtitle),
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
              ),
            ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
              child: Icon(Icons.bookmark),
              backgroundColor: Colors.red,
              label: 'Rep',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                Scaffold.of(context).showBottomSheet(
                  (context) => Container(
                    height: 350.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(10.0),
                          topRight: const Radius.circular(10.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView(
                          children: <Widget>[
                            Text(
                              'Create New Perk',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 150.0,
                                child: TextField(
                                  onChanged: (val) {
                                    rep = int.parse(val);
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Reputation',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 150.0,
                                child: TextField(
                                  onChanged: (val) {
                                    level = int.parse(val);
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    labelText: 'Level',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            RaisedButton(
                              onPressed: () {
                                if (level == null || rep == null) {
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      content: Text("Fields can't be empty"),
                                    ),
                                  );
                                  return;
                                }

                                createPerk(level, 'rep', rep);
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Create Perk',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.blue[300],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
          SpeedDialChild(
            child: Icon(Icons.card_membership),
            backgroundColor: Colors.blue,
            label: 'Badge',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              Scaffold.of(context).showBottomSheet(
                (context) => Container(
                  height: 350.0,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView(
                        children: <Widget>[
                          Text(
                            'Create New Perk',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 250.0,
                              child: TextField(
                                onChanged: (val) {
                                  badge = val;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Badge',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 150.0,
                              child: TextField(
                                onChanged: (val) {
                                  level = int.parse(val);
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Level',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            onPressed: () {
                              if (level == null || badge == null) {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Fields can't be empty"),
                                  ),
                                );
                                return;
                              }

                              createPerk(level, 'badge', badge);
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Create Perk',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue[300],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.perm_identity),
            backgroundColor: Colors.green,
            label: 'Role',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              Scaffold.of(context).showBottomSheet(
                (context) => Container(
                  height: 350.0,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView(
                        children: <Widget>[
                          Text(
                            'Create New Perk',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 150.0,
                              child: ChipsInput(
                                decoration: InputDecoration(
                                  labelText: 'Role',
                                ),
                                maxChips: 1,
                                findSuggestions: (String query) {
                                  if (query.length != 0) {
                                    var lowercaseQuery = query.toLowerCase();
                                    return roles.where((role) {
                                      return role.name
                                              .toLowerCase()
                                              .contains(query.toLowerCase()) ||
                                          role.id.contains(query);
                                    }).toList(growable: false)
                                      ..sort((a, b) => a.name
                                          .toLowerCase()
                                          .indexOf(lowercaseQuery)
                                          .compareTo(b.name
                                              .toLowerCase()
                                              .indexOf(lowercaseQuery)));
                                  } else {
                                    return const <Role>[];
                                  }
                                },
                                onChanged: (data) {
                                  role = data[0];
                                },
                                chipBuilder: (context, state, role) {
                                  return InputChip(
                                    key: ObjectKey(role.id),
                                    label: Text(role.name),
                                    onDeleted: () => state.deleteChip(role),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  );
                                },
                                suggestionBuilder: (context, state, role) {
                                  return ListTile(
                                    key: ObjectKey(role.id),
                                    title: Text(role.name),
                                    onTap: () => state.selectSuggestion(role),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 150.0,
                              child: TextField(
                                onChanged: (val) {
                                  level = int.parse(val);
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Level',
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RaisedButton(
                            onPressed: () {
                              if (level == null || role == null) {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Fields can't be empty"),
                                  ),
                                );
                                return;
                              }

                              createPerk(level, 'role', role.name);
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Create Perk',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue[300],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
