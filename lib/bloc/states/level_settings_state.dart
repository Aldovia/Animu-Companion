import 'package:animu/models/role.dart';
import 'package:animu/models/settings.dart';
import 'package:animu/models/text_channel.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LevelSettingsState extends Equatable {
  const LevelSettingsState();

  @override
  List<Object> get props => [];
}

class LevelSettingsEmpty extends LevelSettingsState {}

class LevelSettingsLoading extends LevelSettingsState {}

class LevelSettingsLoaded extends LevelSettingsState {
  final Settings settings;
  final List<TextChannel> channels;
  final List<Role> roles;

  const LevelSettingsLoaded(
      {@required this.settings, @required this.channels, @required this.roles})
      : assert(settings != null && channels != null && roles != null);

  @override
  List<Object> get props => [settings, channels, roles];
}

class LevelSettingsError extends LevelSettingsState {}
