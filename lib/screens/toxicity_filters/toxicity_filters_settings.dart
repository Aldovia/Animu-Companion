import 'package:animu/shared/constants.dart';
import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ToxicityFiltersSettings extends StatelessWidget {
  const ToxicityFiltersSettings({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToxicityFiltersSettingsBloc,
        ToxicityFiltersSettingsState>(builder: (context, state) {
      if (state is ToxicityFiltersSettingsLoading)
        return Center(
          child: CircularProgressIndicator(),
        );

      if (state is ToxicityFiltersSettingsError)
        return Center(
          child: Text('An unexpected error occured'),
        );

      if (state is ToxicityFiltersSettingsUnavailable)
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.ribbon,
                size: 50.0,
                color: Colors.grey[700],
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "You've discovered a Plus Feature",
                style: TextStyle(color: Colors.grey[800]),
              ),
              SizedBox(
                height: 30.0,
              ),
              GradientButton(
                increaseWidthBy: 50.0,
                callback: () async {
                  const url = 'https://www.patreon.com/Aldovia';
                  if (await canLaunch(url))
                    await launch(url);
                  else
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "There seems to be a problem openning the link, please open it manually: https://patreon.com/Aldovia"),
                      backgroundColor: Colors.red,
                    ));
                },
                child: Text('Upgrade to Plus'),
              )
            ],
          ),
        );

      if (state is ToxicityFiltersSettingsLoaded) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Filters',
              style: Constants().headingStyle,
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Toxicity'),
                        Switch(
                          value: state.settings.filterToxicity,
                          onChanged: (val) {
                            BlocProvider.of<ToxicityFiltersSettingsBloc>(
                                    context)
                                .add(
                              UpdateToxicityFiltersSettings(
                                key: 'toxicityFilters.toxicity',
                                value: val,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Severe Toxicity'),
                        Switch(
                          value: state.settings.filterSevereToxicity,
                          onChanged: (val) {
                            BlocProvider.of<ToxicityFiltersSettingsBloc>(
                                    context)
                                .add(
                              UpdateToxicityFiltersSettings(
                                key: 'toxicityFilters.severeToxicity',
                                value: val,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Profanity'),
                        Switch(
                          value: state.settings.filterProfanity,
                          onChanged: (val) {
                            BlocProvider.of<ToxicityFiltersSettingsBloc>(
                                    context)
                                .add(
                              UpdateToxicityFiltersSettings(
                                key: 'toxicityFilters.profanity',
                                value: val,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Sexually Explicit'),
                        Switch(
                          value: state.settings.filterSexuallyExplicit,
                          onChanged: (val) {
                            BlocProvider.of<ToxicityFiltersSettingsBloc>(
                                    context)
                                .add(
                              UpdateToxicityFiltersSettings(
                                key: 'toxicityFilters.sexuallyExplicit',
                                value: val,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Identity Attack'),
                        Switch(
                          value: state.settings.filterSexuallyExplicit,
                          onChanged: (val) {
                            BlocProvider.of<ToxicityFiltersSettingsBloc>(
                                    context)
                                .add(
                              UpdateToxicityFiltersSettings(
                                key: 'toxicityFilters.identityAttack',
                                value: val,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Threat'),
                        Switch(
                          value: state.settings.filterThreat,
                          onChanged: (val) {
                            BlocProvider.of<ToxicityFiltersSettingsBloc>(
                                    context)
                                .add(
                              UpdateToxicityFiltersSettings(
                                key: 'toxicityFilters.threat',
                                value: val,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Insult'),
                        Switch(
                          value: state.settings.filterInsult,
                          onChanged: (val) {
                            BlocProvider.of<ToxicityFiltersSettingsBloc>(
                                    context)
                                .add(
                              UpdateToxicityFiltersSettings(
                                key: 'toxicityFilters.insult',
                                value: val,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Flirtation'),
                        Switch(
                          value: state.settings.filterFlirtation,
                          onChanged: (val) {
                            BlocProvider.of<ToxicityFiltersSettingsBloc>(
                                    context)
                                .add(
                              UpdateToxicityFiltersSettings(
                                key: 'toxicityFilters.flirtation',
                                value: val,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Settings',
              style: Constants().headingStyle,
            ),
            SizedBox(
              height: 10.0,
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: ChipsInput(
                        decoration: InputDecoration(
                          labelText: 'Reports Channel',
                        ),
                        maxChips: 1,
                        initialValue: [state.settings.logReports] ?? [],
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
                          BlocProvider.of<ToxicityFiltersSettingsBloc>(context)
                              .add(
                            UpdateToxicityFiltersSettings(
                              key: 'logChannels.reports',
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
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Delete Toxic Messages'),
                        Switch(
                          value: state.settings.deleteToxicMessages,
                          onChanged: (val) {
                            BlocProvider.of<ToxicityFiltersSettingsBloc>(
                                    context)
                                .add(
                              UpdateToxicityFiltersSettings(
                                key: 'deleteToxicMessages',
                                value: val,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }

      return Text('...');
    });
  }
}
