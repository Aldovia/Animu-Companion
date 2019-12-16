import 'package:animu_common/animu_common.dart';
import 'package:animu/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Charts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        List<Widget> chartsList = [
          // Growth over past x days
          Card(
            child: Padding(
              padding: EdgeInsets.fromLTRB(32.0, 32.0, 16.0, 8.0),
              child: BlocBuilder<ChartsBloc, ChartsState>(
                builder: (context, state) {
                  if (state is ChartsLoading)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  if (state is ChartsLoaded) {
                    List<charts.Series<TimeSeriesMembers, DateTime>>
                        _createGrowthData() {
                      return [
                        charts.Series<TimeSeriesMembers, DateTime>(
                          id: 'Members Over Time',
                          colorFn: (_, __) =>
                              charts.MaterialPalette.blue.shadeDefault,
                          domainFn: (TimeSeriesMembers members, _) =>
                              members.time,
                          measureFn: (TimeSeriesMembers members, _) =>
                              members.members,
                          data: state.growthRate,
                        )
                      ];
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Growth over past ${state.growthRate.length} days',
                          style: Constants().headingStyle,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 200.0,
                          child: charts.TimeSeriesChart(
                            _createGrowthData(),
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
                            value: state.growthRate.length,
                            onChanged: (newValue) {
                              BlocProvider.of<ChartsBloc>(context).add(
                                  FetchCharts(
                                      growthCycle: newValue,
                                      joinedCycle: state.joinedRate.length));
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
                    );
                  }

                  if (state is ChartsError)
                    return Text(
                      'An unexpected error occurred',
                      style: TextStyle(color: Colors.grey),
                    );

                  return Text('...');
                },
              ),
            ),
          ),

          // Joined over past x days
          Card(
            child: Padding(
              padding: EdgeInsets.fromLTRB(32.0, 32.0, 16.0, 8.0),
              child: BlocBuilder<ChartsBloc, ChartsState>(
                builder: (context, state) {
                  if (state is ChartsLoading)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  if (state is ChartsLoaded) {
                    List<charts.Series<TimeSeriesMembers, DateTime>>
                        _createJoinedData() {
                      return [
                        charts.Series<TimeSeriesMembers, DateTime>(
                          id: 'Members Joined Over Time',
                          colorFn: (_, __) =>
                              charts.MaterialPalette.blue.shadeDefault,
                          domainFn: (TimeSeriesMembers members, _) =>
                              members.time,
                          measureFn: (TimeSeriesMembers members, _) =>
                              members.members,
                          data: state.joinedRate,
                        )
                      ];
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Joined over past ${state.joinedRate.length} days',
                          style: Constants().headingStyle,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 200.0,
                          child: charts.TimeSeriesChart(
                            _createJoinedData(),
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
                            value: state.joinedRate.length,
                            onChanged: (newValue) {
                              BlocProvider.of<ChartsBloc>(context).add(
                                  FetchCharts(
                                      growthCycle: state.growthRate.length,
                                      joinedCycle: newValue));
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
                    );
                  }

                  if (state is ChartsError)
                    return Text(
                      'An unexpected error occurred',
                      style: TextStyle(color: Colors.grey),
                    );

                  return Text('...');
                },
              ),
            ),
          ),
        ];
        return chartsList[index];
      },
      itemWidth: 350.0,
      itemHeight: 350.0,
      itemCount: 2,
      layout: SwiperLayout.STACK,
    );
  }
}
