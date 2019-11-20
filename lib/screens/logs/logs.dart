import 'dart:convert';

import 'package:animu/models/log.dart';
import 'package:animu/shared/config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';

class Logs extends StatefulWidget {
  final String token;
  Logs({this.token});

  @override
  _LogsState createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  bool isLoading = true;

  List<Log> logs = [];

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  void fetchInitialData() async {
    final http.Response resRaw = await http
        .get('$serverAddress/api/logs?token=${widget.token}&limit=20');

    final Map res = jsonDecode(resRaw.body);

    if (mounted)
      setState(() {
        isLoading = false;

        for (var i = 0; i < res['logs'].length; i++) {
          logs.add(
            Log(
              type: res['logs'][i]['event'],
              log: res['logs'][i]['data']['content'],
              user: res['logs'][i]['data']['authorTag'],
              time: DateTime.parse(res['logs'][i]['data']['createdAt']),
            ),
          );
        }
      });
  }

  void fetchData(int offset) async {
    final http.Response resRaw = await http.get(
        'http://140.82.39.61:8080/api/logs?token=${widget.token}&limit=20&offset=$offset');

    final Map res = jsonDecode(resRaw.body);

    if (mounted)
      setState(() {
        for (var i = 0; i < res['logs'].length; i++) {
          logs.add(
            Log(
              type: res['logs'][i]['event'],
              log: res['logs'][i]['data']['content'],
              user: res['logs'][i]['data']['authorTag'],
              time: DateTime.parse(res['logs'][i]['data']['createdAt']),
            ),
          );
          print(logs.length);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Logs',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? SpinKitRotatingCircle(
              color: Colors.blue,
              size: 50.0,
            )
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: logs.length,
                      itemBuilder: (BuildContext context, int i) {
                        if (i == logs.length - 1) fetchData(logs.length);
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.chat),
                            title: Text(
                              logs[i].log.length > 50
                                  ? '${logs[i].log.substring(0, 50)}...'
                                  : logs[i].log,
                            ),
                            subtitle: Text(
                                '${logs[i].user} • ${timeago.format(logs[i].time)}'),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
