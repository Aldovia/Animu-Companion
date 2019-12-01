import 'package:equatable/equatable.dart';

class TextChannel extends Equatable {
  final String id;
  final String name;

  TextChannel({this.id, this.name});

  @override
  List<Object> get props => [id, name];

  static TextChannel fromJson(dynamic json) {
    return TextChannel(id: json['id'], name: json['name']);
  }
}
