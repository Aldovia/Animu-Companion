import 'package:equatable/equatable.dart';

class Role extends Equatable {
  final String id;
  final String name;

  Role({this.id, this.name});

  @override
  List<Object> get props => [id, name];

  static Role fromJson(dynamic json) {
    return Role(id: json['id'], name: json['name']);
  }
}
