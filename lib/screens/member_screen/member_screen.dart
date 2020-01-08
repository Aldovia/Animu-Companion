import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';

class MemberScreen extends StatelessWidget {
  final Member member;

  MemberScreen({Key key, this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(member.profileWallpaperURL);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 60.0,
                  backgroundImage: NetworkImage(member.avatarURL),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  member.displayName,
                  style: Theme.of(context).textTheme.display1,
                ),
                SizedBox(
                  height: 10,
                ),
                Chip(
                  label: Text(
                    member.activeBadge ?? 'No active badge',
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          member.level.toString(),
                          style: Theme.of(context).textTheme.display1,
                        ),
                        Text(
                          'Level',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          member.reputation.toString(),
                          style: Theme.of(context).textTheme.display1,
                        ),
                        Text(
                          'Reputation',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 300.0,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.grey[200]
                          : Colors.grey[800],
                      blurRadius: 10,
                    ),
                  ],
                  color: Theme.of(context).primaryColor,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(40.0),
                    topRight: const Radius.circular(40.0),
                  ),
                ),
                child: Center(
                  child: Text('Stuff here'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
