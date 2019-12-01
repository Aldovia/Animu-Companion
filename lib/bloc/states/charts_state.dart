import 'package:animu/models/time_series_members.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ChartsState extends Equatable {
  const ChartsState();

  @override
  List<Object> get props => [];
}

class ChartsEmpty extends ChartsState {}

class ChartsLoading extends ChartsState {}

class ChartsLoaded extends ChartsState {
  final List<TimeSeriesMembers> growthRate;
  final List<TimeSeriesMembers> joinedRate;

  const ChartsLoaded({@required this.growthRate, @required this.joinedRate})
      : assert(growthRate != null && joinedRate != null);

  @override
  List<Object> get props => [growthRate, joinedRate];
}

class ChartsError extends ChartsState {}
