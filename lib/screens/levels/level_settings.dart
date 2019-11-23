import 'dart:convert';

import 'package:animu/models/role.dart';
import 'package:animu/models/text_channel.dart';
import 'package:animu/shared/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class LevelSettings extends StatefulWidget {
  final String token;
  LevelSettings({this.token});

  @override
  _LevelSettingsState createState() => _LevelSettingsState();
}

class _LevelSettingsState extends State<LevelSettings> {
  int expRateSliderVal;
  int expTimeSliderVal;
  bool isLoading = true;

  List<TextChannel> blacklistedChannels = [];
  List<Role> blacklistedRoles = [];
  List<TextChannel> channels = [];
  List<Role> roles = [];

  @override
  void initState() {
    super.initState();
    fetchInitialState();
  }

  void fetchInitialState() async {
    final List<http.Response> dataRaw = await Future.wait(
      [
        http.get('$serverAddress/api/settings?token=${widget.token}'),
        http.get('$serverAddress/api/roles?token=${widget.token}'),
        http.get('$serverAddress/api/channels?token=${widget.token}'),
      ],
    );

    final List data = dataRaw.map((d) => jsonDecode(d.body)).toList();

    final Map settings = data[0];
    final Map rolesFetched = data[1];
    final Map channelsFetched = data[2];

    if (mounted)
      setState(() {
        isLoading = false;

        expRateSliderVal = settings['settings']['expRate'];
        expTimeSliderVal = settings['settings']['expTime'];

        for (var i = 0; i < rolesFetched['roles'].length; i++) {
          roles.add(
            Role(
              id: rolesFetched['roles'][i]['id'],
              name: rolesFetched['roles'][i]['name'],
            ),
          );
        }

        for (var i = 0; i < channelsFetched['channels'].length; i++) {
          channels.add(
            TextChannel(
              id: channelsFetched['channels'][i]['id'],
              name: channelsFetched['channels'][i]['name'],
            ),
          );
        }

        for (var i = 0;
            i < settings['settings']['ignoreLevelRoles'].length;
            i++) {
          final Role tempRole = roles.firstWhere(
              (r) => r.id == settings['settings']['ignoreLevelRoles'][i]);
          blacklistedRoles.add(
            Role(id: tempRole.id, name: tempRole.name),
          );
        }

        for (var i = 0;
            i < settings['settings']['ignoreExpChannels'].length;
            i++) {
          final TextChannel tempChannel = channels.firstWhere(
              (r) => r.id == settings['settings']['ignoreExpChannels'][i]);
          blacklistedChannels.add(
            TextChannel(id: tempChannel.id, name: tempChannel.name),
          );
        }
      });
  }

  void updateExpRate(val) async {
    final Map<String, dynamic> data = {'key': 'expRate', 'value': val};

    final body = jsonEncode(data);

    await http.post('$serverAddress/api/settings?token=${widget.token}',
        headers: {"Content-Type": "application/json"}, body: body);
  }

  void updateExpTime(val) async {
    final Map<String, dynamic> data = {'key': 'expTime', 'value': val};

    final body = jsonEncode(data);

    await http.post('$serverAddress/api/settings?token=${widget.token}',
        headers: {"Content-Type": "application/json"}, body: body);
  }

  void updateBlacklistedRoles(List<Role> val) async {
    final Map<String, dynamic> data = {
      'key': 'ignoreLevelRoles',
      'value': val.map((v) => v.id).toList()
    };

    final body = jsonEncode(data);

    await http.post('$serverAddress/api/settings?token=${widget.token}',
        headers: {"Content-Type": "application/json"}, body: body);
  }

  void updateBlacklistedChannels(List<TextChannel> val) async {
    final Map<String, dynamic> data = {
      'key': 'ignoreExpChannels',
      'value': val.map((v) => v.id).toList()
    };

    final body = jsonEncode(data);

    await http.post('$serverAddress/api/settings?token=${widget.token}',
        headers: {"Content-Type": "application/json"}, body: body);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SpinKitRotatingCircle(
            color: Colors.blue,
            size: 50.0,
          )
        : Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: ListView(
              children: ListTile.divideTiles(
                context: context,
                tiles: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: ChipsInput(
                          decoration: InputDecoration(
                            labelText: 'Blacklist Roles',
                          ),
                          initialValue: blacklistedRoles,
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
                            updateBlacklistedRoles(data);
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
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: ChipsInput(
                          decoration: InputDecoration(
                            labelText: 'Blacklist Channels',
                          ),
                          initialValue: blacklistedChannels,
                          findSuggestions: (String query) {
                            if (query.length != 0) {
                              var lowercaseQuery = query.toLowerCase();
                              return channels.where((channel) {
                                return channel.name
                                        .toLowerCase()
                                        .contains(query.toLowerCase()) ||
                                    channel.id.contains(query);
                              }).toList(growable: false)
                                ..sort((a, b) => a.name
                                    .toLowerCase()
                                    .indexOf(lowercaseQuery)
                                    .compareTo(b.name
                                        .toLowerCase()
                                        .indexOf(lowercaseQuery)));
                            } else {
                              return const <TextChannel>[];
                            }
                          },
                          onChanged: (data) {
                            updateBlacklistedChannels(data);
                          },
                          chipBuilder: (context, state, channel) {
                            return InputChip(
                              key: ObjectKey(channel.id),
                              label: Text(channel.name),
                              onDeleted: () => state.deleteChip(channel),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            );
                          },
                          suggestionBuilder: (context, state, channel) {
                            return ListTile(
                              key: ObjectKey(channel.id),
                              title: Text(channel.name),
                              onTap: () => state.selectSuggestion(channel),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Exp Rate',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 18.0,
                            ),
                          ),
                          Slider(
                            onChanged: (val) {
                              setState(() {
                                expRateSliderVal = val.toInt();
                              });
                            },
                            onChangeEnd: (val) {
                              updateExpRate(val);
                            },
                            value: expRateSliderVal.toDouble(),
                            min: 1,
                            divisions: 9,
                            max: 10,
                            activeColor: Colors.blue,
                            label: expRateSliderVal.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Exp Time',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 18.0,
                            ),
                          ),
                          Slider(
                            onChanged: (val) {
                              setState(() {
                                expTimeSliderVal = val.toInt();
                              });
                            },
                            onChangeEnd: (val) {
                              updateExpTime(val);
                            },
                            value: expTimeSliderVal.toDouble(),
                            min: 1,
                            divisions: 59,
                            max: 60,
                            activeColor: Colors.blue,
                            label: expTimeSliderVal.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ).toList(),
            ),
          );
  }
}
