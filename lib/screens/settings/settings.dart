import 'package:animu/screens/upgrade/upgrade.dart';
import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsPage extends StatefulWidget {
  final Function clearToken;
  final AnimuRepository animuRepository;
  SettingsPage({this.clearToken, this.animuRepository});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Container(
          child: ListView(
            children: ListTile.divideTiles(
              context: context,
              tiles: [
                ListTile(
                  leading: Icon(
                    FontAwesomeIcons.crown,
                    color: Colors.lime,
                  ),
                  title: Text('Upgrade'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Upgrade(
                                  animuRepository: widget.animuRepository,
                                )));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.power_settings_new, color: Colors.red),
                  title: Text('Log Out'),
                  onTap: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(LoggedOut());
                  },
                ),
              ],
            ).toList(),
          ),
        ),
      ),
    );
  }
}
