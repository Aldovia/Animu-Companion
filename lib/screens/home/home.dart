import 'dart:convert';

import 'package:animu/models/time_series_members.dart';
import 'package:animu/shared/config.dart';
import 'package:animu/shared/constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String token;
  Home({this.token});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;

  int activeMembersCount;
  List<TimeSeriesMembers> growthRate = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final http.Response resRaw =
        await http.get('$serverAddress/api/guild?token=${widget.token}');

    final http.Response growthResRaw = await http
        .get('$serverAddress/api/growth?token=${widget.token}&cycle=7');

    final Map res = jsonDecode(resRaw.body);
    final Map growthRes = jsonDecode(growthResRaw.body);

    setState(() {
      isLoading = false;
      activeMembersCount = res['guild']['onlineMemberCount'];

      for (var i = 0; i < growthRes['growth'].length; i++) {
        growthRate.add(
          TimeSeriesMembers(
              DateTime.now().subtract(
                Duration(days: i),
              ),
              growthRes['growth'][i]),
        );
      }
    });
  }

  void fetchDaysGrowth(int days) async {
    print('Fetching data for $days days');

    final http.Response growthResRaw = await http
        .get('$serverAddress/api/growth?token=${widget.token}&cycle=$days');
    final Map growthRes = jsonDecode(growthResRaw.body);

    growthRate.clear();

    setState(() {
      for (var i = 0; i < growthRes['growth'].length; i++) {
        growthRate.add(
          TimeSeriesMembers(
              DateTime.now().subtract(
                Duration(days: i),
              ),
              growthRes['growth'][i]),
        );
      }
    });
  }

  List<charts.Series<TimeSeriesMembers, DateTime>> _createSampleData() {
    return [
      charts.Series<TimeSeriesMembers, DateTime>(
        id: 'Members Over Time',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesMembers members, _) => members.time,
        measureFn: (TimeSeriesMembers members, _) => members.members,
        data: growthRate,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
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
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Column(
                  children: <Widget>[
                    // Active Now
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              'Active Now',
                              style: Constants().headingStyle,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              '$activeMembersCount Members',
                              style: TextStyle(
                                fontSize: 26.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Growth over past 7 days
                    Card(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(32.0, 32.0, 16.0, 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              'Growth over past ${growthRate.length} days',
                              style: Constants().headingStyle,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              height: 200.0,
                              child: charts.TimeSeriesChart(
                                _createSampleData(),
                                animate: true,
                                behaviors: [
                                  charts.SeriesLegend(
                                    position: charts.BehaviorPosition.bottom,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: DropdownButton(
                                value: growthRate.length,
                                onChanged: (newValue) {
                                  fetchDaysGrowth(newValue);
                                },
                                items: [7, 14, 30, 60, 90].map((days) {
                                  return DropdownMenuItem(
                                    child: new Text('${days.toString()} Days'),
                                    value: days,
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
