import 'package:animu/models/level_leaderboards_user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LevelLeaderboardsState extends Equatable {
  const LevelLeaderboardsState();

  @override
  List<Object> get props => [];
}

class LevelLeaderboardsEmpty extends LevelLeaderboardsState {}

class LevelLeaderboardsLoading extends LevelLeaderboardsState {}

class LevelLeaderboardsLoaded extends LevelLeaderboardsState {
  final List<LevelLeaderboardsUser> levelLeaderboardsUsers;

  const LevelLeaderboardsLoaded({@required this.levelLeaderboardsUsers})
      : assert(levelLeaderboardsUsers != null);

  @override
  List<Object> get props => [levelLeaderboardsUsers];
}

class LevelLeaderboardsError extends LevelLeaderboardsState {}
