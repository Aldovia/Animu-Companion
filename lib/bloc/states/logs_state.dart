import 'package:animu/models/log.dart';
import 'package:equatable/equatable.dart';

abstract class LogsState extends Equatable {
  const LogsState();

  @override
  List<Object> get props => [];
}

class LogsUninitialized extends LogsState {}

class LogsLoaded extends LogsState {
  final List<Log> logs;
  final bool hasReachedMax;

  const LogsLoaded({this.logs, this.hasReachedMax});

  LogsLoaded copyWith({List<Log> logs, bool hasReachedMax}) {
    return LogsLoaded(
      logs: logs ?? this.logs,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [logs, hasReachedMax];

  @override
  String toString() =>
      'LogsLoaded { logs: ${logs.length}, hasReachedMax: $hasReachedMax }';
}

class LogsError extends LogsState {}
