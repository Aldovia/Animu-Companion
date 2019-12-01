import 'package:equatable/equatable.dart';

abstract class LevelsState extends Equatable {
  const LevelsState();

  @override
  List<Object> get props => [];
}

class LevelsInitial extends LevelsState {}

class LevelsLoading extends LevelsState {}

class LevelsOn extends LevelsState {}

class LevelsOff extends LevelsState {}

class LevelsError extends LevelsState {}
