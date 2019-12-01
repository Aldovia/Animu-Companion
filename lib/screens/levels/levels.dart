import 'package:animu/bloc/blocs/level_leaderboards_bloc.dart';
import 'package:animu/bloc/blocs/level_settings_bloc.dart';
import 'package:animu/bloc/blocs/levels_bloc.dart';
import 'package:animu/bloc/events/level_leaderboards_event.dart';
import 'package:animu/bloc/events/level_settings_event.dart';
import 'package:animu/bloc/events/levels_event.dart';
import 'package:animu/bloc/repos/animu_repo.dart';
import 'package:animu/bloc/states/levels_state.dart';
import 'package:animu/screens/levels/level_leaderboards.dart';
import 'package:animu/screens/levels/level_perks.dart';
import 'package:animu/screens/levels/level_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Levels extends StatelessWidget {
  final AnimuRepository animuRepository;

  Levels({@required this.animuRepository});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        color: Colors.white,
        child: Center(
          child: Scaffold(
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
                BlocBuilder<LevelsBloc, LevelsState>(
                  builder: (context, state) => Switch(
                    onChanged: (val) {
                      BlocProvider.of<LevelsBloc>(context)
                          .add(ToggleLevels(val: val));
                    },
                    value: state is LevelsOn ? true : false,
                  ),
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
            body: LevelsWrapper(
              animuRepository: animuRepository,
            ),
          ),
        ),
      ),
    );
  }
}

class LevelsWrapper extends StatelessWidget {
  final AnimuRepository animuRepository;

  LevelsWrapper({@required this.animuRepository});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelsBloc, LevelsState>(
      builder: (context, state) {
        print(state);
        return TabBarView(
          children: <Widget>[
            state is LevelsLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : state is LevelsOn
                    ? BlocProvider(
                        builder: (context) {
                          return LevelLeaderboardsBloc(
                              animuRepository: animuRepository)
                            ..add(FetchLevelLeaderboards());
                        },
                        child: LevelLeaderboards())
                    : state is LevelsError
                        ? Center(
                            child: Text('An unexpected error occured'),
                          )
                        : Center(
                            child: Text('Enable Levels to view Leaderboards'),
                          ),
            state is LevelsLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : state is LevelsOn
                    ? BlocProvider(
                        builder: (context) {
                          return LevelSettingsBloc(
                              animuRepository: animuRepository)
                            ..add(FetchLevelSettings());
                        },
                        child: LevelSettings(),
                      )
                    : state is LevelsError
                        ? Center(
                            child: Text('An unexpected error occured'),
                          )
                        : Center(
                            child: Text('Enable Levels to view settings'),
                          ),
            state is LevelsLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : state is LevelsOn
                    ? LevelPerks(
                        animuRepository: animuRepository,
                      )
                    : state is LevelsError
                        ? Center(
                            child: Text('An unexpected error occured'),
                          )
                        : Center(
                            child: Text('Enable Levels to view level perks'),
                          ),
          ],
        );
      },
    );
  }
}
