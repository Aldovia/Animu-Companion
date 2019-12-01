import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LevelSettingsEvent extends Equatable {
  const LevelSettingsEvent();

  @override
  List<Object> get props => [];
}

class FetchLevelSettings extends LevelSettingsEvent {}

class UpdateLevelSettings extends LevelSettingsEvent {
  final String key;
  final dynamic value;

  UpdateLevelSettings({@required this.key, @required this.value});

  @override
  List<Object> get props => [key, value];

  @override
  String toString() => 'UpdateLevelSettings {key: $key, value: $value}';
}
