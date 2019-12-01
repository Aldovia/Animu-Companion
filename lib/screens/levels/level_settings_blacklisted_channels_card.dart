import 'package:animu/bloc/blocs/level_settings_bloc.dart';
import 'package:animu/bloc/events/level_settings_event.dart';
import 'package:animu/bloc/states/level_settings_state.dart';
import 'package:animu/models/text_channel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

class LevelSettingsBlacklistedChannelsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelSettingsBloc, LevelSettingsState>(
      builder: (context, state) {
        if (state is LevelSettingsLoaded)
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: ChipsInput(
                  decoration: InputDecoration(
                    labelText: 'Blacklist Channels',
                  ),
                  initialValue: state.settings.ignoreExpChannels,
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
                    BlocProvider.of<LevelSettingsBloc>(context).add(
                      UpdateLevelSettings(
                        key: 'ignoreExpChannels',
                        value: data.map((c) => c.id).toList(),
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
