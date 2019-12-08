import 'package:animu/bloc/blocs/levels_bloc.dart';
import 'package:animu/bloc/events/levels_event.dart';
import 'package:animu/bloc/repos/animu_repo.dart';
import 'package:animu/screens/home/home.dart';
import 'package:animu/screens/levels/levels.dart';
import 'package:animu/screens/logs/logs.dart';
import 'package:animu/screens/settings/settings.dart';
import 'package:animu/screens/upgrade/upgrade.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Wrapper extends StatefulWidget {
  final AnimuRepository animuRepository;
  final String token;
  final Function clearToken;
  Wrapper({@required this.animuRepository, this.token, this.clearToken});

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: IndexedStack(
          index: currentIndex,
          children: <Widget>[
            Home(
              animuRepository: widget.animuRepository,
            ),
            Logs(
              animuRepository: widget.animuRepository,
            ),
            BlocProvider(
              builder: (context) {
                return LevelsBloc(animuRepository: widget.animuRepository)
                  ..add(FetchLevels());
              },
              child: Levels(
                animuRepository: widget.animuRepository,
              ),
            ),
            Upgrade(
              animuRepository: widget.animuRepository,
            ),
            SettingsPage(
              clearToken: widget.clearToken,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        fabLocation: BubbleBottomBarFabLocation.end,
        hasNotch: true,
        hasInk: true,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.blue,
              icon: Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Colors.blue,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Colors.deepPurple,
              icon: Icon(
                Icons.access_time,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.access_time,
                color: Colors.deepPurple,
              ),
              title: Text("Logs")),
          BubbleBottomBarItem(
              backgroundColor: Colors.orange,
              icon: Icon(
                Icons.show_chart,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.show_chart,
                color: Colors.orange,
              ),
              title: Text("Levels")),
          BubbleBottomBarItem(
              backgroundColor: Colors.lime,
              icon: Icon(
                FontAwesomeIcons.crown,
                size: 18.0,
                color: Colors.black,
              ),
              activeIcon: Icon(
                FontAwesomeIcons.crown,
                size: 18.0,
                color: Colors.lime,
              ),
              title: Text("Pro")),
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.settings,
                color: Colors.red,
              ),
              title: Text("Settings")),
        ],
      ),
    );
  }
}
