import 'package:animu/screens/self_roles/self_roles_settings_channel_card.dart';
import 'package:animu/screens/self_roles/self_roles_settings_message_card.dart';
import 'package:animu_common/animu_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelfRolesSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelfRolesSettingsBloc, SelfRolesSettingsState>(
      builder: (context, state) {
        if (state is SelfRolesSettingsLoading)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (state is SelfRolesSettingsLoaded)
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: ListView(
              children: ListTile.divideTiles(
                context: context,
                tiles: [
                  SelfRolesSettingsChannelCard(),
                  SelfRolesSettingsMessageCard(),
                ],
              ).toList(),
            ),
          );

        if (state is SelfRolesSettingsError)
          return Center(
            child: Text('An unexpected error occured'),
          );

        return Text('...');
      },
    );
  }
}
