import 'package:animu/models/level_perk.dart';
import 'package:animu/models/role.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LevelPerksState extends Equatable {
  const LevelPerksState();

  @override
  List<Object> get props => [];
}

class LevelPerksEmpty extends LevelPerksState {}

class LevelPerksLoading extends LevelPerksState {}

class LevelPerksLoaded extends LevelPerksState {
  final List<LevelPerk> levelPerks;
  final List<Role> roles;

  const LevelPerksLoaded({@required this.levelPerks, @required this.roles})
      : assert(levelPerks != null && roles != null);

  @override
  List<Object> get props => [levelPerks, roles];
}

class LevelPerksError extends LevelPerksState {}
