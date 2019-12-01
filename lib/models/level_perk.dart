import 'package:animu/models/role.dart';
import 'package:equatable/equatable.dart';

class LevelPerk extends Equatable {
  final int level;
  final String badge;
  final Role role;
  final int rep;

  LevelPerk({this.level, this.badge, this.role, this.rep});

  @override
  List<Object> get props => [level, badge, role, rep];

  static LevelPerk fromJson(dynamic json, dynamic rolesJson) {
    Role role;

    for (int i = 0; i < rolesJson.length; i++) {
      if (json['role'] == rolesJson[i]['name'])
        role = Role.fromJson(rolesJson[i]);
    }
    return LevelPerk(
        level: json['level'],
        badge: json['badge'],
        role: role,
        rep: json['rep']);
  }
}
