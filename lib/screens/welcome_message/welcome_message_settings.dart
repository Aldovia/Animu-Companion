import 'dart:async';

import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';

class WelcomeMessageSettings extends StatefulWidget {
  @override
  _WelcomeMessageSettingsState createState() => _WelcomeMessageSettingsState();
}

class _WelcomeMessageSettingsState extends State<WelcomeMessageSettings> {
  Timer editMessageOnStoppedTyping;
  Timer editURLOnStoppedTyping;

  @override
  Widget build(BuildContext context) {
    _onMessageChangeHandler(value) {
      const duration = Duration(milliseconds: 800);
      if (editMessageOnStoppedTyping != null) {
        setState(() => editMessageOnStoppedTyping.cancel());
      }
      setState(
        () => editMessageOnStoppedTyping = new Timer(
            duration,
            () => {
                  BlocProvider.of<WelcomeMessageSettingsBloc>(context).add(
                    UpdateWelcomeMessageSettings(
                      key: 'welcomeMessage',
                      value: value,
                    ),
                  ),
                }),
      );
    }

    _onURLChangeHandler(value) {
      const duration = Duration(milliseconds: 800);
      if (editURLOnStoppedTyping != null) {
        setState(() => editURLOnStoppedTyping.cancel());
      }
      setState(
        () => editURLOnStoppedTyping = new Timer(
            duration,
            () => {
                  BlocProvider.of<WelcomeMessageSettingsBloc>(context).add(
                    UpdateWelcomeMessageSettings(
                      key: 'welcomeImageURL',
                      value: value,
                    ),
                  ),
                }),
      );
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              left: 8.0,
            ),
            child: Text(
              'Settings',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
              child: BlocBuilder<WelcomeMessageSettingsBloc,
                  WelcomeMessageSettingsState>(
                builder: (context, state) {
                  if (state is WelcomeMessageSettingsLoading)
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                  if (state is WelcomeMessageSettingsLoaded)
                    return Column(
                      children: <Widget>[
                        ChipsInput(
                          decoration: InputDecoration(
                            labelText: 'Welcome Channel',
                          ),
                          maxChips: 1,
                          initialValue: state.settings.welcomeChannel != null
                              ? [state.settings.welcomeChannel]
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
                                    .compareTo(b.name
                                        .toLowerCase()
                                        .indexOf(lowercaseQuery)));
                            } else {
                              return const <TextChannel>[];
                            }
                          },
                          onChanged: (data) {
                            BlocProvider.of<WelcomeMessageSettingsBloc>(context)
                                .add(
                              UpdateWelcomeMessageSettings(
                                key: 'welcomeChannel',
                                value: data.length > 0 ? data[0].id : null,
                              ),
                            );
                          },
                          chipBuilder: (context, state, channel) {
                            return InputChip(
                              key: ObjectKey(channel.id),
                              label: Text(channel.name),
                              onDeleted: () => state.deleteChip(channel),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
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
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          maxLength: 500,
                          initialValue: state.settings.welcomeMessage ?? '',
                          decoration:
                              InputDecoration(labelText: 'Welcome Message'),
                          onChanged: _onMessageChangeHandler,
                        ),
                        TextFormField(
                          initialValue: state.settings.welcomeImageURL ?? '',
                          decoration: InputDecoration(
                              labelText: 'Welcome Image/GIF URL'),
                          onChanged: _onURLChangeHandler,
                        ),
                      ],
                    );

                  if (state is WelcomeMessageSettingsError)
                    return Center(
                      child: Text('An unexpected error occured'),
                    );

                  return Text('...');
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
