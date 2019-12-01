import 'package:equatable/equatable.dart';

abstract class GuildEvent extends Equatable {
  const GuildEvent();
}

class FetchGuild extends GuildEvent {
  @override
  List<Object> get props => [];
}
