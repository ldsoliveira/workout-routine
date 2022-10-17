import 'package:workout_routine/features/routine/data/models/exercise_model.dart';
import 'package:workout_routine/features/routine/data/repositories/routine_repository_impl.dart';
import 'package:workout_routine/features/routine/domain/entities/exercise/exercise.dart';

class ExerciseUsecase {
  const ExerciseUsecase({
    required this.repository,
  });

  final RoutineRepositoryImpl repository;

  Future<List<ExerciseModel>> getExercises({required int dayOfWeek}) =>
      repository.getExercises(dayOfWeek: dayOfWeek);

  Future<void> addExercise({required ExerciseModel exercise}) =>
      repository.addExercise(exercise: exercise);

  Future<void> removeExercise({required Exercise exercise}) =>
      repository.removeExercise(exercise: exercise);

  Future<void> updateExercise({required ExerciseModel exercise}) =>
      repository.updateExercise(exercise: exercise);
}