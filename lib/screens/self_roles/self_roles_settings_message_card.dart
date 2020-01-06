import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelfRolesSettingsMessageCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelfRolesSettingsBloc, SelfRolesSettingsState>(
      builder: (context, state) {
        if (state is SelfRolesSettingsLoaded)
          return Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextFormField(
                  initialValue: state.settings.selfRolesMessage ?? '',
                  decoration: InputDecoration(labelText: 'Message ID'),
                  onChanged: (val) {
                    if (val.length == 18)
                      BlocProvider.of<SelfRolesSettingsBloc>(context).add(
                        UpdateSelfRolesSettings(
                          key: 'selfRolesMessage',
                          value: val,
                        ),
                      );
                  },
                ),
              ),
            ),
          );

        return Text('...');
      },
    );
  }
}
