import 'package:animu_common/animu_common.dart';
import 'package:animu/screens/rep/rep_leaderboards.dart';
import 'package:animu/screens/rep/rep_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Rep extends StatelessWidget {
  final AnimuRepository animuRepository;

  Rep({@required this.animuRepository});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        color: Colors.white,
        child: Center(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              title: Text(
                'Rep',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.white,
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.show_chart, color: Colors.black),
                  ),
                  Tab(
                    icon: Icon(Icons.settings, color: Colors.black),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                BlocProvider(
                  create: (context) =>
                      RepLeaderboardsBloc(animuRepository: animuRepository)
                        ..add(FetchRepLeaderboards()),
                  child: RepLeaderboards(),
                ),
                BlocProvider(
                  create: (context) =>
                      RepSettingsBloc(animuRepository: animuRepository)
                        ..add(FetchRepSettings()),
                  child: RepSettings(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
