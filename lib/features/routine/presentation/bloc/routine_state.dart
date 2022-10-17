part of 'routine_bloc.dart';

@immutable
abstract class RoutineState {}

class RoutineInitial extends RoutineState {}


class UpdateWeekdayIndexState extends RoutineState {
  final int index;
  final List<ExerciseModel> exercises;

  UpdateWeekdayIndexState(this.index, this.exercises);
}

class LoadedRoutinesState extends RoutineState {
  final List<ExerciseModel> exercises;

  LoadedRoutinesState(this.exercises);
}

