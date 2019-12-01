import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ChartsEvent extends Equatable {
  const ChartsEvent();

  @override
  List<Object> get props => [];
}

class FetchCharts extends ChartsEvent {
  final int growthCycle;
  final int joinedCycle;

  FetchCharts({@required this.growthCycle, @required this.joinedCycle});

  @override
  List<Object> get props => [growthCycle, joinedCycle];

  @override
  String toString() =>
      'FetchCharts {growthCycle: $growthCycle, joinedCycle: $joinedCycle}';
}
