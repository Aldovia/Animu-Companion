import 'package:equatable/equatable.dart';

class Log extends Equatable {
  final String type;
  final String log;
  final String user;
  final String imageUrl;
  final DateTime time;

  Log({this.type, this.log, this.user, this.imageUrl, this.time});

  @override
  List<Object> get props => [type, log, user, imageUrl, time];

  static Log fromJson(dynamic json) {
    return Log(
      type: json['event'],
      log: json['data']['content'],
      user: json['data']['authorTag'],
      time: DateTime.parse(json['data']['createdAt']),
      imageUrl: json['data']['authorAvatarUrl'],
    );
  }
}
