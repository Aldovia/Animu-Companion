import 'package:animu/bloc/blocs/level_settings_bloc.dart';
import 'package:animu/bloc/events/level_settings_event.dart';
import 'package:animu/bloc/states/level_settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LevelSettingsExpRateCard extends StatefulWidget {
  @override
  _LevelSettingsExpRateCardState createState() =>
      _LevelSettingsExpRateCardState();
}

class _LevelSettingsExpRateCardState extends State<LevelSettingsExpRateCard> {
  double sliderVal = 1;
  bool isValSet = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelSettingsBloc, LevelSettingsState>(
      builder: (context, state) {
        if (state is LevelSettingsLoaded) {
          if (!isValSet) {
            sliderVal = state.settings.expRate.toDouble();
            isValSet = true;
          }
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Exp Rate',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18.0,
                    ),
                  ),
                  Slider(
                    onChanged: (val) {
                      if (mounted)
                        setState(() {
                          sliderVal = val;
                        });
                    },
                    onChangeEnd: (val) {
                      BlocProvider.of<LevelSettingsBloc>(context).add(
                          UpdateLevelSettings(
                              key: 'expRate', value: val.toInt()));
                    },
                    value: sliderVal,
                    min: 1,
                    divisions: 9,
                    max: 10,
                    activeColor: Colors.blue,
                    label: sliderVal.toInt().toString(),
                  ),
                ],
              ),
            ),
          );
        }

        return Text('...');
      },
    );
  }
}
