import 'package:flutter/material.dart';

class LevelsHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Levels'),
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
                        'Levels let you give your server members a reason to be active.\n\n'),
                TextSpan(
                  text: 'Settings\n\n',
                  style: Theme.of(context).textTheme.title,
                ),
                TextSpan(
                    text:
                        'There are 5 configurable settings that let you change level up system in your server,\n\n'),
                TextSpan(text: ' • Blacklisted Roles\n'),
                TextSpan(text: ' • Blacklisted Channels\n'),
                TextSpan(text: ' • Exp Bottles\n'),
                TextSpan(text: ' • Exp Rate\n'),
                TextSpan(text: ' • Exp Time\n\n'),
                TextSpan(
                    text:
                        'Blacklisted roles lets you blacklist specific roles from showing levels in their profiles.\n\n'),
                TextSpan(
                    text:
                        'Members with blacklisted roles will still earn exp and show up on leaderboards, but their profiles will not show their level/exp.\n\n'),
                TextSpan(
                    text:
                        'Blacklisted Channels lets you configure channels where users can\'t earn exp, you can use this to blacklist channels like spam channel, etc.\n\n'),
                TextSpan(
                    text:
                        'Exp Bottles are special items that can be purchased from shop, '),
                TextSpan(
                    text:
                        'if you allow exp bottles in your server, then users can use exp bottles in your server to earn exp and level up fast.\n\n'),
                TextSpan(
                    text:
                        'Each time a member in your server uses Exp bottle, you\'ll get 25% of that bottles worth of coins, you can use those coins however you wish.\n\n'),
                TextSpan(
                    text:
                        'Exp Rate is the rate of exp per message, you can increase it to make it easier to level up or decrease it to make it more difficult to level up\n\n'),
                TextSpan(
                    text:
                        'Exp Time is the amount of time (in seconds) that Animu will wait before assigning exp for the next message\n\n'),
                TextSpan(
                  text: 'Level Up Perks\n\n',
                  style: Theme.of(context).textTheme.title,
                ),
                TextSpan(
                    text:
                        'Animu lets you create 3 different types of level up perks,\n\n'),
                TextSpan(text: ' • Badge\n'),
                TextSpan(text: ' • Reputation\n'),
                TextSpan(text: ' • Role\n\n'),
                WidgetSpan(
                  child: Icon(
                    Icons.info_outline,
                    size: 17.0,
                    color: Colors.blue,
                  ),
                ),
                TextSpan(
                    text:
                        ' Badges are a kind of achievement that server owner/admin can give to their members. Member can select a badge to show up on their profile.\n\n'),
                WidgetSpan(
                  child: Icon(
                    Icons.info_outline,
                    size: 17.0,
                    color: Colors.blue,
                  ),
                ),
                TextSpan(
                    text:
                        ' Reputation is a measure of how reputable a member is in a specific server. To learn more about reputation, head over to "Reputation" guide.\n\n'),
                TextSpan(
                    text:
                        'You can view all the existing level perks by going over to Levels ('),
                WidgetSpan(
                  child: Icon(
                    Icons.show_chart,
                    size: 17.0,
                  ),
                ),
                TextSpan(text: ') and tapping on Perks ('),
                WidgetSpan(
                  child: Icon(
                    Icons.star,
                    size: 17.0,
                  ),
                ),
                TextSpan(text: ') Tab.\n\n'),
                TextSpan(text: 'To create a new perk, tap on ('),
                WidgetSpan(
                  child: Icon(
                    Icons.menu,
                    size: 17.0,
                  ),
                ),
                TextSpan(text: ') then select ('),
                WidgetSpan(
                  child: Icon(
                    Icons.bookmark,
                    size: 17.0,
                  ),
                ),
                TextSpan(text: ') to create a reputation perk, or ('),
                WidgetSpan(
                  child: Icon(
                    Icons.card_membership,
                    size: 17.0,
                  ),
                ),
                TextSpan(text: ') to create a badge perk, or ('),
                WidgetSpan(
                  child: Icon(
                    Icons.person_outline,
                    size: 17.0,
                  ),
                ),
                TextSpan(text: ') to create a role perk.'),
                TextSpan(
                    text:
                        'Once you\'ve created a perk, members will be able to get that perk upon hitting that level.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
