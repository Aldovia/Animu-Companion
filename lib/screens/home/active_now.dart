import 'package:animu/bloc/blocs/guild_bloc.dart';
import 'package:animu/bloc/states/guild_state.dart';
import 'package:animu/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveNow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Active Now',
              style: Constants().headingStyle,
            ),
            SizedBox(
              height: 10.0,
            ),
            BlocBuilder<GuildBloc, GuildState>(
              builder: (context, state) {
                if (state is GuildLoading)
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                if (state is GuildLoaded)
                  return Text(
                    '${state.guild.onlineMemberCount} Members',
                    style: TextStyle(
                      fontSize: 26.0,
                    ),
                  );

                if (state is GuildError)
                  return Text(
                    'An unexpected error occurred',
                    style: TextStyle(color: Colors.grey),
                  );

                return Text('...');
              },
            ),
          ],
        ),
      ),
    );
  }
}