import 'package:animu/bloc/repos/animu_api_client.dart';
import 'package:animu/models/growth_rate.dart';
import 'package:animu/models/guild.dart';
import 'package:animu/models/joined_rate.dart';
import 'package:animu/models/level_leaderboards_user.dart';
import 'package:animu/models/log.dart';
import 'package:animu/models/settings.dart';
import 'package:animu/models/time_series_members.dart';
import 'package:meta/meta.dart';

class AnimuRepository {
  final AnimuApiClient animuApiClient;

  AnimuRepository({@required this.animuApiClient})
      : assert(animuApiClient != null);

  /// Returns Guild
  Future<Guild> getGuild() async {
    return await animuApiClient.fetchGuild();
  }

  /// Returns Charts for home page
  Future<List<List<TimeSeriesMembers>>> getCharts(
      {int growthCycle = 7, int joinedCycle = 7}) async {
    List<TimeSeriesMembers> growthRateList = [];
    List<TimeSeriesMembers> joinedRateList = [];

    List<dynamic> charts = await Future.wait([
      animuApiClient.fetchGrowthRate(growthCycle: growthCycle),
      animuApiClient.fetchJoinedRate(joinedCycle: joinedCycle),
    ]);

    final GrowthRate growthRate = charts[0];
    final JoinedRate joinedRate = charts[1];

    for (var i = 0; i < growthRate.growthRate.length; i++) {
      growthRateList.add(
        TimeSeriesMembers(
          DateTime.now().subtract(
            Duration(days: i),
          ),
          growthRate.growthRate[i],
        ),
      );
    }

    for (var i = 0; i < joinedRate.joinedRate.length; i++) {
      joinedRateList.add(
        TimeSeriesMembers(
          DateTime.now().subtract(
            Duration(days: i),
          ),
          joinedRate.joinedRate[i],
        ),
      );
    }

    return [growthRateList, joinedRateList];
  }

  /// Returns Logs of authorized guild
  Future<List<Log>> getLogs({int limit = 20, int offset = 0}) {
    return animuApiClient.fetchLogs(limit: limit, offset: offset);
  }

  /// Returns level leaderboard of authorized guild
  Future<List<LevelLeaderboardsUser>> getLevelsLeaderboard() {
    return animuApiClient.fetchLevelLeaderboardsUsers();
  }

  /// Returns Settings of authorized guild
  Future<Settings> getSettings() {
    return animuApiClient.fetchSettings();
  }

  /// Updates settings of authorized guild
  Future<Settings> updateSettings({String key, dynamic value}) {
    return animuApiClient.updateSettings(key: key, value: value);
  }

  /// Returns data for level settings page
  Future<List<dynamic>> getLevelSettings() async {
    List<dynamic> data = await Future.wait([
      animuApiClient.fetchSettings(),
      animuApiClient.fetchRoles(),
      animuApiClient.fetchChannels()
    ]);
    return data;
  }

  /// Update settings for Levels
  Future<List<dynamic>> updateLevelSettings(
      {@required String key, @required dynamic value}) async {
    List<dynamic> data = await Future.wait([
      animuApiClient.updateSettings(key: key, value: value),
      animuApiClient.fetchRoles(),
      animuApiClient.fetchChannels()
    ]);
    return data;
  }

  /// Returns Level Perks for authorized guild
  Future<List<dynamic>> getLevelPerks() async {
    List<dynamic> data = await Future.wait([
      animuApiClient.fetchLevelPerks(),
      animuApiClient.fetchRoles(),
    ]);
    return data;
  }

  /// Creates new level perk and returns all level perks
  Future<List<dynamic>> createLevelPerk(
      {@required level, @required perkName, @required perkValue}) async {
    List<dynamic> data = await Future.wait([
      animuApiClient.createLevelPerk(
          level: level, perkName: perkName, perkValue: perkValue),
      animuApiClient.fetchRoles(),
    ]);
    return data;
  }
}
