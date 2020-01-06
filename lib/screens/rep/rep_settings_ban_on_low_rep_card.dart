import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepSettingsBanOnLowRepCard extends StatefulWidget {
  @override
  _RepSettingsBanOnLowRepCardState createState() =>
      _RepSettingsBanOnLowRepCardState();
}

class _RepSettingsBanOnLowRepCardState
    extends State<RepSettingsBanOnLowRepCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepSettingsBloc, RepSettingsState>(
      builder: (context, state) {
        if (state is RepSettingsLoaded) {
          return Card(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Ban on Low Rep',
                      style: Theme.of(context).textTheme.subtitle,
                    ),
                    Switch(
                      onChanged: (val) {
                        BlocProvider.of<RepSettingsBloc>(context).add(
                            UpdateRepSettings(key: 'banOnLowRep', value: val));
                      },
                      value: state.settings.banOnLowRep,
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
