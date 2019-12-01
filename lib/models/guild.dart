import 'package:equatable/equatable.dart';

class Guild extends Equatable {
  final String id;
  final String name;
  final int memberCount;
  final int onlineMemberCount;

  const Guild({this.id, this.name, this.memberCount, this.onlineMemberCount});

  @override
  List<Object> get props => [
        id,
        name,
        memberCount,
        onlineMemberCount,
      ];

  static Guild fromJson(dynamic json) {
    final guild = json['guild'];
    return Guild(
        id: guild['id'],
        name: guild['name'],
        memberCount: guild['memberCount'],
        onlineMemberCount: guild['onlineMemberCount']);
  }
}
