import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  final Function clearToken;
  Settings({this.clearToken});

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
                  leading: Icon(Icons.power_settings_new, color: Colors.red),
                  title: Text('Log Out'),
                  onTap: () {
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Logging Out'),
                      ),
                    );
                    widget.clearToken();
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
