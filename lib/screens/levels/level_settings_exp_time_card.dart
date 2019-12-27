import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LevelSettingsExpTimeCard extends StatefulWidget {
  @override
  _LevelSettingsExpTimeCardState createState() =>
      _LevelSettingsExpTimeCardState();
}

class _LevelSettingsExpTimeCardState extends State<LevelSettingsExpTimeCard> {
  double sliderVal = 1;
  bool isValSet = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelSettingsBloc, LevelSettingsState>(
      builder: (context, state) {
        if (state is LevelSettingsLoaded) {
          if (!isValSet) {
            sliderVal = state.settings.expTime.toDouble();
            isValSet = true;
          }
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Exp Time',
                    style: Theme.of(context).textTheme.title,
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
                              key: 'expTime', value: val.toInt()));
                    },
                    value: sliderVal.toDouble(),
                    min: 1,
                    divisions: 59,
                    max: 60,
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
