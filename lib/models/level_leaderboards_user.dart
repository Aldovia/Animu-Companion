import 'package:equatable/equatable.dart';

class LevelLeaderboardsUser extends Equatable {
  final String avatarUrl;
  final String username;
  final int level;

  LevelLeaderboardsUser({this.avatarUrl, this.username, this.level});

  @override
  List<Object> get props => [avatarUrl, username, level];

  static LevelLeaderboardsUser fromJson(dynamic json) {
    return LevelLeaderboardsUser(
      avatarUrl: json['avatarURL'],
      username: json['username'],
      level: json['level'],
    );
  }
}
