import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LevelSettingsExpBottleCard extends StatefulWidget {
  @override
  _LevelSettingsExpBottleCardState createState() =>
      _LevelSettingsExpBottleCardState();
}

class _LevelSettingsExpBottleCardState
    extends State<LevelSettingsExpBottleCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelSettingsBloc, LevelSettingsState>(
      builder: (context, state) {
        if (state is LevelSettingsLoaded) {
          return Card(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Exp Bottles',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 18.0,
                      ),
                    ),
                    Switch(
                      onChanged: (val) {
                        BlocProvider.of<LevelSettingsBloc>(context).add(
                            UpdateLevelSettings(
                                key: 'allowExpBottles', value: val));
                      },
                      value: state.settings.allowExpBottles,
                    )
                  ],
                )),
          );
        }

        return Text('...');
      },
    );
  }
}