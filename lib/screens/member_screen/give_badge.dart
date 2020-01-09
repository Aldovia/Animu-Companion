import 'package:flutter/material.dart';

class GiveBadgeDialog extends StatefulWidget {
  final Function giveBadge;

  GiveBadgeDialog({Key key, this.giveBadge}) : super(key: key);

  @override
  _GiveBadgeDialogState createState() => _GiveBadgeDialogState();
}

class _GiveBadgeDialogState extends State<GiveBadgeDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Give Badge'),
      content: TextField(
        maxLength: 30,
        controller: _controller,
        decoration: InputDecoration(labelText: 'Badge Name'),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        RaisedButton(
          color: Colors.blue,
          child: Text('Give'),
          onPressed: () {
            widget.giveBadge(_controller.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
