import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LevelPerksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelPerksBloc, LevelPerksState>(
      builder: (context, state) {
        if (state is LevelPerksLoading)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (state is LevelPerksLoaded)
          return Container(
            child: ListView.builder(
              itemCount: state.levelPerks.length,
              itemBuilder: (BuildContext context, int i) {
                String subtitle = '';
                if (state.levelPerks[i].role != null)
                  subtitle += 'Role: ${state.levelPerks[i].role.name}\n';

                if (state.levelPerks[i].badge != null)
                  subtitle += 'Badge: ${state.levelPerks[i].badge}\n';

                if (state.levelPerks[i].rep != null)
                  subtitle += 'Rep: ${state.levelPerks[i].rep}';

                return Dismissible(
                  key: Key(state.levelPerks[i].level.toString()),
                  background: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(Icons.delete),
                          Icon(Icons.delete),
                        ],
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    BlocProvider.of<LevelPerksBloc>(context).add(
                      DeleteLevelPerk(level: state.levelPerks[i].level),
                    );

                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Deleted Level ${state.levelPerks[i].level.toString()} Perks'),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        (i + 1).toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    title:
                        Text('Level ${state.levelPerks[i].level.toString()}'),
                    subtitle: Text(subtitle),
                  ),
                );
              },
            ),
          );

        if (state is LevelPerksError)
          return Center(
            child: Text('An unexpected error occured'),
          );

        return Text('...');
      },
    );
  }
}
