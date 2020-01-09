import 'package:animu/screens/member_screen/give_badge.dart';
import 'package:animu/screens/member_screen/kick_ban_member.dart';
import 'package:animu/screens/member_screen/member_details.dart';
import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MemberScreenActions extends StatelessWidget {
  final Member member;

  MemberScreenActions({this.member});

  @override
  Widget build(BuildContext context) {
    void _giveBadge(String badgeName) {
      BlocProvider.of<MemberBloc>(context).add(
        GiveBadge(
          memberID: member.id,
          badgeName: badgeName,
        ),
      );
    }

    return Center(
      child: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person_outline, color: Colors.blue),
            title: Text('View More Info'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MemberDetails(
                    member: member,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard, color: Colors.yellow),
            title: Text('Give Badge'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return GiveBadgeDialog(
                    giveBadge: _giveBadge,
                  );
                },
              );
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.ban, color: Colors.red),
            title: Text('Kick/Ban Member'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) => KickBanMemberDialog(),
            ),
          ),
        ],
      ),
    );
  }
}
