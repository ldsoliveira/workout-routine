part of 'routine_bloc.dart';

@immutable
abstract class RoutineEvent {}

class UpdateWeekdayIndexEvent extends RoutineEvent {
  final int index;

  UpdateWeekdayIndexEvent(this.index);
}

class AddExerciseEvent extends RoutineEvent {
  final String name;
  final int reps;
  final int series;

  AddExerciseEvent({
    required this.name,
    required this.reps,
    required this.series,
  });
}

class RemoveExerciseEvent extends RoutineEvent {
  final Exercise exercise;

  RemoveExerciseEvent({
    required this.exercise,
  });
}

class UpdateDoneExerciseEvent extends RoutineEvent {
  final ExerciseModel exercise;
  final bool isDone;

  UpdateDoneExerciseEvent({
    required this.exercise,
    required this.isDone,
  });
}

class UncheckTodayExercisesEvent extends RoutineEvent {}
