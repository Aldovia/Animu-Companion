import 'package:equatable/equatable.dart';

abstract class LevelLeaderboardsEvent extends Equatable {
  const LevelLeaderboardsEvent();

  @override
  List<Object> get props => [];
}

class FetchLevelLeaderboards extends LevelLeaderboardsEvent {}
