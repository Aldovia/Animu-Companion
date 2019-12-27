import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';

class SelfRoles extends StatelessWidget {
  final AnimuRepository animuRepository;

  SelfRoles({@required this.animuRepository});

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
                'Self Roles',
              ),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.list),
                  ),
                  Tab(
                    icon: Icon(Icons.settings),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Text('Self Roles'),
                Text('Settings'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
