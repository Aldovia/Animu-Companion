import 'dart:async';
import 'dart:convert';

import 'package:animu/models/growth_rate.dart';
import 'package:animu/models/guild.dart';
import 'package:animu/models/joined_rate.dart';
import 'package:animu/models/level_leaderboards_user.dart';
import 'package:animu/models/level_perk.dart';
import 'package:animu/models/log.dart';
import 'package:animu/models/role.dart';
import 'package:animu/models/settings.dart';
import 'package:animu/models/text_channel.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class AnimuApiClient {
  static const baseUrl = 'http://140.82.39.61:8080'; // Public
      // 'http://192.168.1.105:8080'; // Dev testing

  final http.Client httpClient;
  final String token;

  AnimuApiClient({@required this.httpClient, @required this.token})
      : assert(httpClient != null);

  /// Returns Guild using token
  Future<Guild> fetchGuild() async {
    print('Printing Token $token');

    final String guildUrl = '$baseUrl/api/guild?token=$token';
    final http.Response guildResponse = await http.get(guildUrl);

    if (guildResponse.statusCode != 200) {
      throw Exception('error getting guild');
    }

    final guildJson = jsonDecode(guildResponse.body);
    return Guild.fromJson(guildJson);
  }

  /// Returns GrowthRate of a guild
  Future<GrowthRate> fetchGrowthRate({int growthCycle = 7}) async {
    final String growthUrl =
        '$baseUrl/api/growth?token=$token&cycle=$growthCycle';
    final http.Response growthResponse = await http.get(growthUrl);

    if (growthResponse.statusCode != 200) {
      throw Exception('error getting growth rate');
    }

    final growthJson = jsonDecode(growthResponse.body);
    return GrowthRate.fromJson(growthJson);
  }

  /// Returns JoinedRate of a guild
  Future<JoinedRate> fetchJoinedRate({int joinedCycle = 7}) async {
    final String joinedUrl =
        '$baseUrl/api/joined?token=$token&cycle=$joinedCycle';
    final http.Response joinedResponse = await http.get(joinedUrl);

    if (joinedResponse.statusCode != 200) {
      throw Exception('error getting joined rate');
    }

    final joinedJson = jsonDecode(joinedResponse.body);
    return JoinedRate.fromJson(joinedJson);
  }

  /// Returns logs of a guild
  Future<List<Log>> fetchLogs({int limit = 20, int offset = 0}) async {
    final String logsUrl =
        '$baseUrl/api/logs?token=$token&limit=$limit&offset=$offset';
    final http.Response logsResponse = await http.get(logsUrl);

    if (logsResponse.statusCode != 200) {
      throw Exception('error getting logs');
    }

    final logsJson = jsonDecode(logsResponse.body);

    final List<Log> logsList = [];

    for (int i = 0; i < logsJson['logs'].length; i++) {
      logsList.add(Log.fromJson(logsJson['logs'][i]));
    }

    return logsList;
  }

  /// Returns level leaderboard of a guild
  Future<List<LevelLeaderboardsUser>> fetchLevelLeaderboardsUsers() async {
    final String leaderboardsUrl =
        '$baseUrl/api/leaderboards/levels?token=$token';
    final http.Response leaderboardsResponse = await http.get(leaderboardsUrl);

    if (leaderboardsResponse.statusCode != 200) {
      throw Exception('error getting level leaderboards');
    }

    final leaderboardsJson = jsonDecode(leaderboardsResponse.body);

    final List<LevelLeaderboardsUser> leaderboardsList = [];

    for (int i = 0; i < leaderboardsJson['members'].length; i++) {
      leaderboardsList.add(
        LevelLeaderboardsUser.fromJson(leaderboardsJson['members'][i]),
      );
    }

    return leaderboardsList;
  }

  /// Fetch Settings of a guild
  Future<Settings> fetchSettings() async {
    final String settingsUrl = '$baseUrl/api/settings?token=$token';
    final String channelsUrl = '$baseUrl/api/channels?token=$token';
    final String rolesUrl = '$baseUrl/api/roles?token=$token';

    final List<http.Response> responses = await Future.wait(
        [http.get(settingsUrl), http.get(channelsUrl), http.get(rolesUrl)]);

    if (responses[0].statusCode != 200 || responses[1].statusCode != 200) {
      throw Exception('error getting settings');
    }

    final settingsJson = jsonDecode(responses[0].body);
    final channelsJson = jsonDecode(responses[1].body);
    final rolesJson = jsonDecode(responses[2].body);

    return Settings.fromJson(
        settingsJson['settings'], channelsJson['channels'], rolesJson['roles']);
  }

  /// Update settings of a guild
  Future<Settings> updateSettings({String key, dynamic value}) async {
    final String settingsUrl = '$baseUrl/api/settings?token=$token';
    final String channelsUrl = '$baseUrl/api/channels?token=$token';
    final String rolesUrl = '$baseUrl/api/roles?token=$token';

    final Map<String, dynamic> data = {'key': key, 'value': value};

    final body = jsonEncode(data);

    final List<http.Response> responses = await Future.wait([
      http.post(settingsUrl,
          headers: {"Content-Type": "application/json"}, body: body),
      http.get(channelsUrl),
      http.get(rolesUrl)
    ]);

    if (responses[0].statusCode != 200 ||
        responses[1].statusCode != 200 ||
        responses[2].statusCode != 200) {
      throw Exception('error getting settings');
    }

    final settingsJson = jsonDecode(responses[0].body);
    final channelsJson = jsonDecode(responses[1].body);
    final rolesJson = jsonDecode(responses[2].body);

    return Settings.fromJson(
        settingsJson['settings'], channelsJson['channels'], rolesJson['roles']);
  }

  /// Returns roles of a guild
  Future<List<Role>> fetchRoles() async {
    final String rolesUrl = '$baseUrl/api/roles?token=$token';

    final http.Response rolesResponse = await http.get(rolesUrl);

    if (rolesResponse.statusCode != 200) {
      throw Exception('error getting roles');
    }

    final rolesJson = jsonDecode(rolesResponse.body);

    final List<Role> rolesList = [];

    for (int i = 0; i < rolesJson['roles'].length; i++) {
      rolesList.add(
        Role.fromJson(rolesJson['roles'][i]),
      );
    }

    return rolesList;
  }

  /// Returns channels of a guild
  Future<List<TextChannel>> fetchChannels() async {
    final String channelsUrl = '$baseUrl/api/channels?token=$token';

    final http.Response channelsResponse = await http.get(channelsUrl);

    if (channelsResponse.statusCode != 200) {
      throw Exception('error getting channels');
    }

    final channelsJson = jsonDecode(channelsResponse.body);

    final List<TextChannel> channelsList = [];

    for (int i = 0; i < channelsJson['channels'].length; i++) {
      channelsList.add(
        TextChannel.fromJson(channelsJson['channels'][i]),
      );
    }

    return channelsList;
  }

  /// Returns level perks of a guild
  Future<List<LevelPerk>> fetchLevelPerks() async {
    final String levelPerksUrl = '$baseUrl/api/levelperks?token=$token';
    final String rolesUrl = '$baseUrl/api/roles?token=$token';

    final List<http.Response> responses =
        await Future.wait([http.get(levelPerksUrl), http.get(rolesUrl)]);

    if (responses[0].statusCode != 200 || responses[1].statusCode != 200) {
      throw Exception('error getting perks');
    }

    final levelPerksJson = jsonDecode(responses[0].body);
    final rolesJson = jsonDecode(responses[1].body);

    final List<LevelPerk> levelPerksList = [];

    for (int i = 0; i < levelPerksJson['levelPerks'].length; i++) {
      levelPerksList.add(
        LevelPerk.fromJson(levelPerksJson['levelPerks'][i], rolesJson['roles']),
      );
    }

    levelPerksList.sort((a, b) => a.level.compareTo(b.level));

    return levelPerksList;
  }

  Future<List<LevelPerk>> createLevelPerk(
      {@required level, @required perkName, @required perkValue}) async {
    final String levelPerksUrl = '$baseUrl/api/levelperks?token=$token';
    final String rolesUrl = '$baseUrl/api/roles?token=$token';

    final Map<String, dynamic> data = {
      'level': level,
      'perkName': perkName,
      'perkValue': perkValue
    };

    final body = jsonEncode(data);

    final List<http.Response> responses = await Future.wait([
      http.post(levelPerksUrl,
          headers: {"Content-Type": "application/json"}, body: body),
      http.get(rolesUrl)
    ]);

    if (responses[0].statusCode != 200 || responses[1].statusCode != 200) {
      throw Exception('error getting perks');
    }

    final levelPerksJson = jsonDecode(responses[0].body);
    final rolesJson = jsonDecode(responses[1].body);

    final List<LevelPerk> levelPerksList = [];

    for (int i = 0; i < levelPerksJson['levelPerks'].length; i++) {
      levelPerksList.add(
        LevelPerk.fromJson(levelPerksJson['levelPerks'][i], rolesJson['roles']),
      );
    }

    levelPerksList.sort((a, b) => a.level.compareTo(b.level));

    return levelPerksList;
  }
}
