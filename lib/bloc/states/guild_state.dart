import 'package:animu/models/guild.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class GuildState extends Equatable {
  const GuildState();

  @override
  List<Object> get props => [];
}

class GuildEmpty extends GuildState {}

class GuildLoading extends GuildState {}

class GuildLoaded extends GuildState {
  final Guild guild;

  const GuildLoaded({@required this.guild}) : assert(guild != null);

  @override
  List<Object> get props => [guild];
}

class GuildError extends GuildState {}
