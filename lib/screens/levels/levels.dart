import 'package:animu_common/animu_common.dart';
import 'package:animu/screens/levels/level_leaderboards.dart';
import 'package:animu/screens/levels/level_perks.dart';
import 'package:animu/screens/levels/level_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class Levels extends StatelessWidget {
  final AnimuRepository animuRepository;

  Levels({@required this.animuRepository});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        child: Center(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              title: Text(
                'Levels',
              ),
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
                    icon: Icon(Icons.show_chart),
                  ),
                  Tab(
                    icon: Icon(Icons.settings),
                  ),
                  Tab(
                    icon: Icon(Icons.star),
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
        return TabBarView(
          children: <Widget>[
            state is LevelsLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : state is LevelsOn
                    ? BlocProvider(
                        create: (context) {
                          return LevelLeaderboardsBloc(
                              animuRepository: animuRepository)
                            ..add(FetchLevelLeaderboards());
                        },
                        child: LevelLeaderboards())
                    : state is LevelsUnavailable
                        ? Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.play,
                                  size: 50.0,
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  "You've discovered a Lite Feature",
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                GradientButton(
                                  increaseWidthBy: 50.0,
                                  callback: () async {
                                    const url =
                                        'https://www.patreon.com/Aldovia';
                                    if (await canLaunch(url))
                                      await launch(url);
                                    else
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "There seems to be a problem openning the link, please open it manually: https://patreon.com/Aldovia"),
                                        backgroundColor: Colors.red,
                                      ));
                                  },
                                  child: Text('Upgrade to Lite'),
                                )
                              ],
                            ),
                          )
                        : state is LevelsError
                            ? Center(
                                child: Text('An unexpected error occured'),
                              )
                            : Center(
                                child:
                                    Text('Enable Levels to view Leaderboards'),
                              ),
            state is LevelsLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : state is LevelsOn
                    ? BlocProvider(
                        create: (context) {
                          return LevelSettingsBloc(
                              animuRepository: animuRepository)
                            ..add(FetchLevelSettings());
                        },
                        child: LevelSettings(),
                      )
                    : state is LevelsUnavailable
                        ? Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.play,
                                  size: 50.0,
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  "You've discovered a Lite Feature",
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                GradientButton(
                                  increaseWidthBy: 50.0,
                                  callback: () async {
                                    const url =
                                        'https://www.patreon.com/Aldovia';
                                    if (await canLaunch(url))
                                      await launch(url);
                                    else
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "There seems to be a problem openning the link, please open it manually: https://patreon.com/Aldovia"),
                                        backgroundColor: Colors.red,
                                      ));
                                  },
                                  child: Text('Upgrade to Lite'),
                                )
                              ],
                            ),
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
                    : state is LevelsUnavailable
                        ? Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.play,
                                  size: 50.0,
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  "You've discovered a Lite Feature",
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                GradientButton(
                                  increaseWidthBy: 50.0,
                                  callback: () async {
                                    const url =
                                        'https://www.patreon.com/Aldovia';
                                    if (await canLaunch(url))
                                      await launch(url);
                                    else
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            "There seems to be a problem openning the link, please open it manually: https://patreon.com/Aldovia"),
                                        backgroundColor: Colors.red,
                                      ));
                                  },
                                  child: Text('Upgrade to Lite'),
                                )
                              ],
                            ),
                          )
                        : state is LevelsError
                            ? Center(
                                child: Text('An unexpected error occured'),
                              )
                            : Center(
                                child:
                                    Text('Enable Levels to view level perks'),
                              ),
          ],
        );
      },
    );
  }
}
