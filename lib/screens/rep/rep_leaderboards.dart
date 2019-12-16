import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepLeaderboards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepLeaderboardsBloc, RepLeaderboardsState>(
      builder: (context, state) {
        if (state is RepLeaderboardsLoading)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (state is RepLeaderboardsLoaded)
          return Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemCount: state.repLeaderboardsUsers.length,
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
                                        .repLeaderboardsUsers[i].avatarUrl),
                                  ),
                                ],
                              ),
                            ),
                            title: Text(
                              state.repLeaderboardsUsers[i].username.length > 20
                                  ? '${state.repLeaderboardsUsers[i].username.substring(0, 20)}...'
                                  : state.repLeaderboardsUsers[i].username,
                            ),
                            trailing: Text(
                              state.repLeaderboardsUsers[i].rep.toString(),
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

        if (state is RepLeaderboardsError)
          return Center(
            child: Text('An unexpected error occured'),
          );

        return Text('...');
      },
    );
  }
}
