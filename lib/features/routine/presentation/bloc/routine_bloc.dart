import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:workout_routine/features/routine/data/models/exercise_model.dart';
import 'package:workout_routine/features/routine/domain/entities/exercise/exercise.dart';
import 'package:workout_routine/features/routine/domain/usecases/exercise_usecase.dart';

part 'routine_event.dart';
part 'routine_state.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  final ExerciseUsecase _exerciseUsecase;
  int dayOfWeek = 0;

  RoutineBloc(this._exerciseUsecase) : super(RoutineInitial()) {
    on<UpdateWeekdayIndexEvent>(_updateWeekdayIndex);
    on<AddExerciseEvent>(_addExercise);
    on<RemoveExerciseEvent>(_removeExercise);
    on<UpdateDoneExerciseEvent>(_updateDone);
    on<UncheckTodayExercisesEvent>(_uncheckExercises);
  }

  Future<void> _updateWeekdayIndex(UpdateWeekdayIndexEvent event, Emitter<RoutineState> emit) async {
    final exercises = await _exerciseUsecase.getExercises(dayOfWeek: event.index);
    dayOfWeek = event.index;

    emit(UpdateWeekdayIndexState(event.index, exercises));
  }

  Future<void> _addExercise(AddExerciseEvent event, Emitter<RoutineState> emit) async {
    final exercise = ExerciseModel(
        id: DateTime.now().millisecondsSinceEpoch,
        name: event.name,
        repetitions: event.reps,
        series: event.series,
        dayOfWeek: dayOfWeek,
        done: false,
    );

    await _exerciseUsecase.addExercise(exercise: exercise);
    final exercises = await _exerciseUsecase.getExercises(dayOfWeek: dayOfWeek);

    emit(LoadedRoutinesState(exercises));
  }

  Future<void> _removeExercise(RemoveExerciseEvent event, Emitter<RoutineState> emit) async {
    await _exerciseUsecase.removeExercise(exercise: event.exercise);
    final exercises = await _exerciseUsecase.getExercises(dayOfWeek: dayOfWeek);

    emit(LoadedRoutinesState(exercises));
  }

  Future<void> _updateDone(UpdateDoneExerciseEvent event, Emitter<RoutineState> emit) async {
    final exercise = event.exercise.copyWith(
      done: event.isDone,
    );

    await _exerciseUsecase.updateExercise(exercise: exercise);

    final exercises = await _exerciseUsecase.getExercises(dayOfWeek: dayOfWeek);
    emit(LoadedRoutinesState(exercises));
  }

  Future<void> _uncheckExercises(UncheckTodayExercisesEvent event, Emitter<RoutineState> emit) async {
    final exercises = await _exerciseUsecase.getExercises(dayOfWeek: dayOfWeek);

    for(ExerciseModel exercise in exercises) {
      exercise = exercise.copyWith(
        done: false,
      );

      await _exerciseUsecase.updateExercise(exercise: exercise);
    }

    emit(LoadedRoutinesState(exercises));
  }
}
