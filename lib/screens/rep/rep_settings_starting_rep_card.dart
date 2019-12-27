import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepSettingsStartingRepCard extends StatefulWidget {
  @override
  _RepSettingsStartingRepCardState createState() =>
      _RepSettingsStartingRepCardState();
}

class _RepSettingsStartingRepCardState
    extends State<RepSettingsStartingRepCard> {
  double sliderVal = 1;
  bool isValSet = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepSettingsBloc, RepSettingsState>(
      builder: (context, state) {
        if (state is RepSettingsLoaded) {
          if (!isValSet) {
            sliderVal = state.settings.startingRep.toDouble();
            isValSet = true;
          }
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Starting Rep',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  Slider(
                    onChanged: (val) {
                      if (mounted)
                        setState(() {
                          sliderVal = val;
                        });
                    },
                    onChangeEnd: (val) {
                      BlocProvider.of<RepSettingsBloc>(context).add(
                          UpdateRepSettings(
                              key: 'startingRep', value: val.toInt()));
                    },
                    value: sliderVal,
                    min: 1,
                    divisions: 99,
                    max: 100,
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
