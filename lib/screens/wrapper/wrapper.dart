import 'package:animu/screens/home/home.dart';
import 'package:animu/screens/levels/levels.dart';
import 'package:animu/screens/logs/logs.dart';
import 'package:animu/screens/settings/settings.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  final String token;
  final Function clearToken;
  Wrapper({this.token, this.clearToken});

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final List<String> pageTitles = [
    'Home',
    'Logs',
    'Levels',
    'Settings',
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: IndexedStack(
          index: currentIndex,
          children: <Widget>[
            Home(
              token: widget.token,
            ),
            Logs(
              token: widget.token,
            ),
            Levels(
              token: widget.token,
            ),
            Settings(
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
