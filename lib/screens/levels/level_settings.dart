import 'package:animu_common/animu_common.dart';
import 'package:animu/screens/levels/level_settings_blacklisted_channels_card.dart';
import 'package:animu/screens/levels/level_settings_blacklisted_roles_card.dart';
import 'package:animu/screens/levels/level_settings_exp_bottle_card.dart';
import 'package:animu/screens/levels/level_settings_exp_rate_card.dart';
import 'package:animu/screens/levels/level_settings_exp_time_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LevelSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelSettingsBloc, LevelSettingsState>(
      builder: (context, state) {
        if (state is LevelSettingsLoading)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (state is LevelSettingsLoaded)
          return Container(
            child: ListView(
              children: [
                LevelSettingsBlacklistedRolesCard(),
                LevelSettingsBlacklistedChannelsCard(),
                LevelSettingsExpBottleCard(),
                LevelSettingsExpRateCard(),
                LevelSettingsExpTimeCard(),
              ],
            ),
          );

        if (state is LevelSettingsError)
          return Center(
            child: Text('An unexpected error occured'),
          );

        return Text('...');
      },
    );
  }
}
