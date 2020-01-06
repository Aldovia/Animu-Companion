import 'package:animu_common/animu_common.dart';
import 'package:animu/screens/rep/rep_settings_ban_on_low_rep_card.dart';
import 'package:animu/screens/rep/rep_settings_blacklisted_roles_card.dart';
import 'package:animu/screens/rep/rep_settings_starting_rep_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepSettingsBloc, RepSettingsState>(
      builder: (context, state) {
        if (state is RepSettingsLoading)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (state is RepSettingsLoaded)
          return Container(
            child: ListView(
              children: [
                RepSettingsBlacklistedRolesCard(),
                RepSettingsBanOnLowRepCard(),
                RepSettingsStartingRepCard(),
              ],
            ),
          );

        if (state is RepSettingsError)
          return Center(
            child: Text('An unexpected error occured'),
          );

        return Text('...');
      },
    );
  }
}
