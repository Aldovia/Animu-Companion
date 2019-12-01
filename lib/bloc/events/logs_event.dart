import 'package:equatable/equatable.dart';

abstract class LogsEvent extends Equatable {
  const LogsEvent();

  @override
  List<Object> get props => [];
}

class FetchLogs extends LogsEvent {}
