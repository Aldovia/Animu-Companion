import 'package:animu/screens/help/help.dart';
import 'package:animu/screens/logs/logs.dart';
import 'package:animu/screens/toxicity_filters/toxicity_filters.dart';
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
        ),
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
                    Icons.brightness_3,
                  ),
                  title: Text('Dark mode'),
                  trailing: Switch(
                    value: Theme.of(context).brightness == Brightness.dark
                        ? true
                        : false,
                    onChanged: (val) {
                      BlocProvider.of<ThemeBloc>(context).add(
                        ToggleTheme(val: val ? 'dark' : 'light'),
                      );
                    },
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.chat_bubble_outline,
                  ),
                  title: Text('Toxicity Filters'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ToxicityFilters(
                          animuRepository: widget.animuRepository,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.access_time,
                    color: Colors.purple,
                  ),
                  title: Text('Logs'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Logs(
                          animuRepository: widget.animuRepository,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.help_outline,
                    color: Colors.blue,
                  ),
                  title: Text('Help'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Help(),
                      ),
                    );
                  },
                ),
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
                        ),
                      ),
                    );
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
