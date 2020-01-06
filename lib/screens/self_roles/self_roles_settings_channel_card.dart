import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

class SelfRolesSettingsChannelCard extends StatelessWidget {
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
                child: ChipsInput(
                  decoration: InputDecoration(
                    labelText: 'Self Roles Channel',
                  ),
                  maxChips: 1,
                  initialValue: state.settings.selfRolesChannel != null
                      ? [state.settings.selfRolesChannel]
                      : [],
                  findSuggestions: (String query) {
                    if (query.length != 0) {
                      var lowercaseQuery = query.toLowerCase();
                      return state.channels.where((channel) {
                        return channel.name
                                .toLowerCase()
                                .contains(query.toLowerCase()) ||
                            channel.id.contains(query);
                      }).toList(growable: false)
                        ..sort((a, b) => a.name
                            .toLowerCase()
                            .indexOf(lowercaseQuery)
                            .compareTo(
                                b.name.toLowerCase().indexOf(lowercaseQuery)));
                    } else {
                      return const <TextChannel>[];
                    }
                  },
                  onChanged: (data) {
                    BlocProvider.of<SelfRolesSettingsBloc>(context).add(
                      UpdateSelfRolesSettings(
                        key: 'selfRolesChannel',
                        value: data.length > 0 ? data[0].id : null,
                      ),
                    );
                  },
                  chipBuilder: (context, state, channel) {
                    return InputChip(
                      key: ObjectKey(channel.id),
                      label: Text(channel.name),
                      onDeleted: () => state.deleteChip(channel),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    );
                  },
                  suggestionBuilder: (context, state, channel) {
                    return ListTile(
                      key: ObjectKey(channel.id),
                      title: Text(channel.name),
                      onTap: () => state.selectSuggestion(channel),
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
