import 'package:flutter/material.dart';

class KickBanMemberDialog extends StatefulWidget {
  final Function kickFunction;
  final Function banFunction;

  KickBanMemberDialog({this.kickFunction, this.banFunction});

  @override
  _KickBanMemberDialogState createState() => _KickBanMemberDialogState();
}

class _KickBanMemberDialogState extends State<KickBanMemberDialog> {
  bool ban = false;
  bool showErr = false;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Kick/Ban Member'),
      content: ListView(
        shrinkWrap: true,
        children: <Widget>[
          if (showErr)
            Text(
              "Reason can't be empty",
              style: TextStyle(color: Colors.red, fontSize: 12.0),
            ),
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
            controller: _controller,
            maxLength: 100,
            validator: (val) {
              if (val.isEmpty) return "Reason Can't be empty";
              return null;
            },
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
          onPressed: () {
            if (_controller.text.isEmpty)
              setState(() {
                showErr = true;
              });
            else {
              if (!ban)
                widget.kickFunction(_controller.text);
              else
                widget.banFunction(_controller.text);

              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
