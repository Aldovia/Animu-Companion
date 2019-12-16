import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LevelLeaderboards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelLeaderboardsBloc, LevelLeaderboardsState>(
      builder: (context, state) {
        if (state is LevelLeaderboardsLoading)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (state is LevelLeaderboardsLoaded)
          return Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: state.levelLeaderboardsUsers.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            leading: SizedBox(
                              width: 70.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${(i + 1).toString()}. ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  if (i < 9)
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(state
                                        .levelLeaderboardsUsers[i].avatarUrl),
                                  ),
                                ],
                              ),
                            ),
                            title: Text(
                              state.levelLeaderboardsUsers[i].username.length >
                                      20
                                  ? '${state.levelLeaderboardsUsers[i].username.substring(0, 20)}...'
                                  : state.levelLeaderboardsUsers[i].username,
                            ),
                            trailing: Text(
                              state.levelLeaderboardsUsers[i].level.toString(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          Divider(),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
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
