import 'package:animu/screens/member_screen/member_screen.dart';
import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LevelLeaderboards extends StatelessWidget {
  final AnimuRepository animuRepository;

  LevelLeaderboards({@required this.animuRepository});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelLeaderboardsBloc, LevelLeaderboardsState>(
      builder: (context, state) {
        if (state is LevelLeaderboardsLoading)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (state is LevelLeaderboardsLoaded)
          return ListView.builder(
            itemCount: state.leaderboardMembers.length,
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                dense: true,
                leading: SizedBox(
                  width: 70.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${(i + 1).toString()}. ',
                        style: Theme.of(context).textTheme.subtitle,
                      ),
                      if (i < 9)
                        SizedBox(
                          width: 10.0,
                        ),
                      Hero(
                        tag: 'level_avatar_${state.leaderboardMembers[i].id}',
                        child: CircleAvatar(
                          radius: 16.0,
                          backgroundImage: NetworkImage(
                              state.leaderboardMembers[i].avatarURL),
                        ),
                      ),
                    ],
                  ),
                ),
                title: Text(
                  state.leaderboardMembers[i].username
                      .replaceAll("[^\\x00-\\x7F]", ""),
                ),
                trailing: Text(
                  state.leaderboardMembers[i].level.toString(),
                  style: Theme.of(context).textTheme.subtitle,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MemberScreen(
                        animuRepository: animuRepository,
                        member: state.leaderboardMembers[i],
                      ),
                    ),
                  );
                },
              );
            },
          );

        if (state is LevelLeaderboardsError)
          return Center(
            child: Text('An unexpected error occured'),
          );

        return Text('...');
      },
    );
  }
}
