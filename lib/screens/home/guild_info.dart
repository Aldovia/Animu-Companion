import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuildInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuildBloc, GuildState>(
      builder: (context, state) {
        if (state is GuildLoading)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (state is GuildLoaded)
          return Card(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Active Now',
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    '${state.guild.onlineMemberCount} Members',
                    style: TextStyle(
                      fontSize: 26.0,
                    ),
                  ),
                ],
              ),
            ),
          );

        if (state is GuildError)
          return Text(
            'An unexpected error occurred',
          );

        return Text('...');
      },
    );
  }
}
