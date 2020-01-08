import 'package:flutter/material.dart';

class MemberScreen extends StatelessWidget {
  final String memberID;

  MemberScreen({Key key, this.memberID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('MemberID: $memberID'),
    );
  }
}
