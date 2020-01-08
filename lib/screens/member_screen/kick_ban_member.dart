import 'package:flutter/material.dart';

class KickBanMemberDialog extends StatefulWidget {
  @override
  _KickBanMemberDialogState createState() => _KickBanMemberDialogState();
}

class _KickBanMemberDialogState extends State<KickBanMemberDialog> {
  bool ban = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Kick/Ban Member'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ChoiceChip(
                label: Text(
                  'Kick',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.body1.color,
                  ),
                ),
                selected: !ban,
                onSelected: (s) => setState(() => ban = !s),
              ),
              ChoiceChip(
                label: Text(
                  'Ban',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.body1.color,
                  ),
                ),
                selected: ban,
                onSelected: (s) => setState(() => ban = s),
              ),
            ],
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Reason'),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        RaisedButton(
          color: Colors.red,
          child: Text(ban ? 'Ban' : 'Kick'),
          onPressed: () {},
        ),
      ],
    );
  }
}
