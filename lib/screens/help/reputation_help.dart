import 'package:flutter/material.dart';

class ReputationHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reputation'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: RichText(
            text: TextSpan(
              style: TextStyle(height: 1.5),
              children: [
                TextSpan(
                    text:
                        'Reputation is measure of how reputable a member in your server is.\n\n'),
                TextSpan(
                  text: 'Settings\n\n',
                  style: Theme.of(context).textTheme.title,
                ),
                TextSpan(
                    text:
                        'There are 3 customizable settings for reputation,\n\n'),
                TextSpan(text: ' • Blacklisted Roles\n'),
                TextSpan(text: ' • Ban on Low Reputation ?\n'),
                TextSpan(text: ' • Starting Reputation\n\n'),
                TextSpan(
                    text:
                        'You can blacklist roles if you don\'t want to show reputation on their profiles.\n\n'),
                TextSpan(
                    text:
                        'Members with blacklisted roles will still show up in leaderboards and can earn reputation.\n\n'),
                TextSpan(
                    text:
                        'If you want to ban users when they hit 0 reputation, you can turn on "Ban on Low Rep".\n\n'),
                TextSpan(
                    text:
                        'Starting reputation is the amount of rep that new members will have when they join your server for the first time.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
