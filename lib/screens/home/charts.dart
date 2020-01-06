import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DateTimeAxisSpecCustom extends charts.DateTimeAxisSpec {
  const DateTimeAxisSpecCustom({
    charts.RenderSpec<DateTime> renderSpec,
    charts.DateTimeTickProviderSpec tickProviderSpec,
    charts.DateTimeTickFormatterSpec tickFormatterSpec,
    bool showAxisLine,
  }) : super(
            renderSpec: renderSpec,
            tickProviderSpec: tickProviderSpec,
            tickFormatterSpec: tickFormatterSpec,
            showAxisLine: showAxisLine);

  @override
  configure(charts.Axis<DateTime> axis, charts.ChartContext context,
      charts.GraphicsFactory graphicsFactory) {
    super.configure(axis, context, graphicsFactory);
    axis.autoViewport = false;
  }
}

class Charts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final axisNumeric = charts.NumericAxisSpec(
      tickProviderSpec: charts.BasicNumericTickProviderSpec(
          desiredMinTickCount: 5, desiredMaxTickCount: 7),
      renderSpec: charts.GridlineRendererSpec(
        labelStyle: charts.TextStyleSpec(
          fontSize: 10,
          color: Theme.of(context).brightness == Brightness.light
              ? charts.MaterialPalette.black
              : charts.MaterialPalette.white,
        ),
      ),
    );

    final axisDateTime = DateTimeAxisSpecCustom(
      tickProviderSpec: charts.DayTickProviderSpec(
        increments: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],
      ),
      renderSpec: charts.GridlineRendererSpec(
        lineStyle:
            charts.LineStyleSpec(color: charts.MaterialPalette.transparent),
        labelStyle: charts.TextStyleSpec(
          fontSize: 10,
          color: Theme.of(context).brightness == Brightness.light
              ? charts.MaterialPalette.black
              : charts.MaterialPalette.white,
        ),
      ),
    );

    // return Swiper(
    //   itemBuilder: (BuildContext context, int index) {
    //     List<Widget> chartsList = [
    // Growth over past x days
    return Column(
      children: <Widget>[
        Card(
          child: BlocBuilder<ChartsBloc, ChartsState>(
            builder: (context, state) {
              if (state is ChartsLoading)
                return SizedBox(
                  height: 250,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );

              if (state is ChartsLoaded) {
                List<charts.Series<TimeSeriesMembers, DateTime>>
                    _createGrowthData() {
                  return [
                    charts.Series<TimeSeriesMembers, DateTime>(
                      id: 'Members Over Time',
                      colorFn: (_, __) =>
                          charts.MaterialPalette.blue.shadeDefault,
                      strokeWidthPxFn: (_, __) => 3,
                      domainFn: (TimeSeriesMembers members, _) => members.time,
                      measureFn: (TimeSeriesMembers members, _) =>
                          members.members,
                      data: state.growthRate,
                    )
                  ];
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Growth over past ',
                            style: Theme.of(context).textTheme.title,
                          ),
                          DropdownButton(
                            value: state.growthRate.length,
                            style: Theme.of(context).textTheme.title,
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 250.0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: charts.TimeSeriesChart(
                          _createGrowthData(),
                          primaryMeasureAxis: axisNumeric,
                          domainAxis: axisDateTime,
                          animate: true,
                          layoutConfig: charts.LayoutConfig(
                            leftMarginSpec: charts.MarginSpec.defaultSpec,
                            topMarginSpec: charts.MarginSpec.defaultSpec,
                            rightMarginSpec: charts.MarginSpec.fixedPixel(5),
                            bottomMarginSpec: charts.MarginSpec.defaultSpec,
                          ),
                          behaviors: [
                            charts.SeriesLegend(
                              position: charts.BehaviorPosition.bottom,
                            ),
                            charts.PanAndZoomBehavior(),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }

              if (state is ChartsError)
                return Text(
                  'An unexpected error occurred',
                );

              return Text('...');
            },
          ),
        ),

        // Joined over past x days
        Card(
          child: BlocBuilder<ChartsBloc, ChartsState>(
            builder: (context, state) {
              if (state is ChartsLoading)
                return SizedBox(
                  height: 250,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );

              if (state is ChartsLoaded) {
                List<charts.Series<TimeSeriesMembers, DateTime>>
                    _createJoinedData() {
                  return [
                    charts.Series<TimeSeriesMembers, DateTime>(
                      id: 'Members Joined Over Time',
                      colorFn: (_, __) =>
                          charts.MaterialPalette.blue.shadeDefault,
                      strokeWidthPxFn: (_, __) => 3,
                      domainFn: (TimeSeriesMembers members, _) => members.time,
                      measureFn: (TimeSeriesMembers members, _) =>
                          members.members,
                      data: state.joinedRate,
                    )
                  ];
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Joined over past ',
                            style: Theme.of(context).textTheme.title,
                          ),
                          DropdownButton(
                            value: state.joinedRate.length,
                            onChanged: (newValue) {
                              BlocProvider.of<ChartsBloc>(context).add(
                                  FetchCharts(
                                      growthCycle: state.growthRate.length,
                                      joinedCycle: newValue));
                            },
                            style: Theme.of(context).textTheme.title,
                            items: [7, 14, 30, 60, 90].map((days) {
                              return DropdownMenuItem(
                                child: new Text('${days.toString()} Days'),
                                value: days,
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: 250.0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: charts.TimeSeriesChart(
                          _createJoinedData(),
                          primaryMeasureAxis: axisNumeric,
                          domainAxis: axisDateTime,
                          layoutConfig: charts.LayoutConfig(
                            leftMarginSpec: charts.MarginSpec.defaultSpec,
                            topMarginSpec: charts.MarginSpec.defaultSpec,
                            rightMarginSpec: charts.MarginSpec.fixedPixel(5),
                            bottomMarginSpec: charts.MarginSpec.defaultSpec,
                          ),
                          animate: true,
                          behaviors: [
                            charts.SeriesLegend(
                              position: charts.BehaviorPosition.bottom,
                            ),
                            charts.PanAndZoomBehavior(),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }

              if (state is ChartsError)
                return Text(
                  'An unexpected error occurred',
                );

              return Text('...');
            },
          ),
        ),
      ],
    );
    //     ];
    //     return chartsList[index];
    //   },
    //   itemWidth: 380.0,
    //   itemHeight: 360.0,
    //   itemCount: 2,
    //   pagination: SwiperPagination(
    //     margin: EdgeInsets.fromLTRB(5, 330, 5, 5),
    //   ),
    //   layout: SwiperLayout.STACK,
    // );
  }
}
