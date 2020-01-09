import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';

class GiveBadgeDialog extends StatefulWidget {
  final Member member;

  GiveBadgeDialog({Key key, this.member}) : super(key: key);

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
            // Use bloc to add badge
            print(_controller.text);
          },
        ),
      ],
    );
  }
}
