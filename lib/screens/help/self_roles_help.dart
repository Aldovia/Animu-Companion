import 'package:flutter/material.dart';

class SelfRolesHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Self Roles'),
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
                        'Self roles are roles that users can assign themselves by simply tapping on a reaction.\n\n'),
                TextSpan(
                  text: 'Self Role Settings\n\n',
                  style: Theme.of(context).textTheme.title,
                ),
                TextSpan(
                    text:
                        'There are 2 settings that you must configure before you try to create any self roles,\n\n'),
                TextSpan(text: ' • Self Roles Channel\n'),
                TextSpan(text: ' • Self Roles Message ID\n\n'),
                TextSpan(
                    text:
                        'Self Roles Channel is the channel where you wish to show self roles and Self Roles Message ID is the ID of message that you wish to add self roles to.\n\n'),
                WidgetSpan(
                  child: Icon(
                    Icons.info_outline,
                    size: 17.0,
                    color: Colors.blue,
                  ),
                ),
                TextSpan(
                    text:
                        ' To get ID of a message, make sure Developer mode is turned on, then right click (or tap and hold on mobile) a message and click/tap on "Copy ID".\n\n'),
                TextSpan(
                  text: 'Creating Self Roles\n\n',
                  style: Theme.of(context).textTheme.title,
                ),
                WidgetSpan(
                  child: Icon(
                    Icons.info_outline,
                    size: 17.0,
                    color: Colors.blue,
                  ),
                ),
                TextSpan(
                    text:
                        ' Before you try to create any self role, make sure you have created that role in your discord server.\n\n'),
                TextSpan(
                    text: 'To create a self role, head over to Self Roles ('),
                WidgetSpan(
                  child: Icon(Icons.person_outline, size: 17.0),
                ),
                TextSpan(text: ') and tap on the blue + button.\n'),
                TextSpan(
                    text:
                        'Now you just have to enter the role and emoji then tap on "Create Self Role".\n\n'),
                TextSpan(
                  text: 'Deleting Self Roles\n\n',
                  style: Theme.of(context).textTheme.title,
                ),
                TextSpan(
                    text:
                        'To delete a self role, you just have to swipe that role in any direction.\n\n'),
                WidgetSpan(
                  child: Icon(
                    Icons.info_outline,
                    size: 17.0,
                    color: Colors.blue,
                  ),
                ),
                TextSpan(text: ' Deleting a self role will '),
                TextSpan(
                    text: 'not\n\n',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: ' • Delete that role from discord\n'),
                TextSpan(text: ' • Remove that role from any user\n'),
                TextSpan(
                    text: ' • Remove reaction from the self role message\n'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
