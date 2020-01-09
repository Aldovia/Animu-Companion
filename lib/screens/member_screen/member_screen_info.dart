import 'package:animu/screens/member_screen/member_screen_actions.dart';
import 'package:animu_common/animu_common.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberScreenInfo extends StatelessWidget {
  final Member member;

  MemberScreenInfo({this.member});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              Hero(
                tag: ['level_avatar_${member.id}', 'rep_avatar_${member.id}'],
                child: CircleAvatar(
                  radius: 60.0,
                  backgroundColor: Theme.of(context).canvasColor,
                  backgroundImage: CachedNetworkImageProvider(member.avatarURL),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                member.displayName,
                style: Theme.of(context).textTheme.display1,
              ),
              SizedBox(
                height: 10,
              ),
              Chip(
                label: Text(
                  member.activeBadge != null && member.activeBadge != ''
                      ? member.activeBadge
                      : 'No active badge',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        member.level.toString(),
                        style: Theme.of(context).textTheme.display1,
                      ),
                      Text(
                        'Level',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        member.reputation.toString(),
                        style: Theme.of(context).textTheme.display1,
                      ),
                      Text(
                        'Reputation',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 200.0,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey[200]
                        : Colors.grey[800],
                    blurRadius: 10,
                  ),
                ],
                color: Theme.of(context).primaryColor,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(30.0),
                  topRight: const Radius.circular(30.0),
                ),
              ),
              child: BlocBuilder<MemberBloc, MemberState>(
                builder: (context, state) {
                  if (state is MemberLoading)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  if (state is MemberError)
                    return Center(
                      child: Text('An unexpected error occured'),
                    );

                  if (state is MemberLoaded)
                    return MemberScreenActions(
                      member: member,
                    );

                  return Text('...');
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
