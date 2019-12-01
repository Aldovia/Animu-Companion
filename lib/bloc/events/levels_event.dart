import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LevelsEvent extends Equatable {
  const LevelsEvent();
}

class FetchLevels extends LevelsEvent {
  @override
  List<Object> get props => [];
}

class ToggleLevels extends LevelsEvent {
  final bool val;

  const ToggleLevels({@required this.val});

  @override
  List<Object> get props => [val];

  @override
  String toString() => 'ToggleLevels { val: $val }';
}
