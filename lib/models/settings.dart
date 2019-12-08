import 'package:animu/models/role.dart';
import 'package:animu/models/text_channel.dart';
import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  final bool enableLevels;
  final int expRate;
  final int expTime;
  final bool allowExpBottles;
  final List<TextChannel> ignoreExpChannels;
  final List<Role> ignoreLevelRoles;

  Settings(
      {this.enableLevels,
      this.expRate,
      this.expTime,
      this.allowExpBottles,
      this.ignoreExpChannels,
      this.ignoreLevelRoles});

  @override
  List<Object> get props => [
        enableLevels,
        expRate,
        expTime,
        allowExpBottles,
        ignoreExpChannels,
        ignoreLevelRoles
      ];

  static Settings fromJson(
      dynamic json, dynamic channelsJson, dynamic rolesJson) {
    final List<TextChannel> tempIgnoreExpChannels = [];
    final List<Role> tempIgnoreLevelRoles = [];

    for (int i = 0; i < channelsJson.length; i++) {
      if (json['ignoreExpChannels'].contains(channelsJson[i]['id']))
        tempIgnoreExpChannels.add(
          TextChannel.fromJson(channelsJson[i]),
        );
    }

    for (int i = 0; i < rolesJson.length; i++) {
      if (json['ignoreLevelRoles'].contains(rolesJson[i]['id']))
        tempIgnoreLevelRoles.add(
          Role.fromJson(rolesJson[i]),
        );
    }

    return Settings(
      enableLevels: json['enableLevels'],
      expRate: json['expRate'],
      expTime: json['expTime'],
      allowExpBottles: json['allowExpBottles'],
      ignoreExpChannels: tempIgnoreExpChannels,
      ignoreLevelRoles: tempIgnoreLevelRoles,
    );
  }
}
