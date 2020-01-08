import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MemberScreen extends StatelessWidget {
  final Member member;

  MemberScreen({Key key, this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  backgroundColor: Theme.of(context).canvasColor,
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
                    member.activeBadge != null && member.activeBadge != ''
                        ? member.activeBadge
                        : 'No active badge',
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
              height: 200.0,
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
                    topLeft: const Radius.circular(30.0),
                    topRight: const Radius.circular(30.0),
                  ),
                ),
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.person_outline, color: Colors.blue),
                        title: Text('View More Info'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading:
                            Icon(Icons.card_giftcard, color: Colors.yellow),
                        title: Text('Manage Badges'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: Icon(FontAwesomeIcons.ban, color: Colors.red),
                        title: Text('Kick/Ban Member'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
