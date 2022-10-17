import 'package:workout_routine/features/routine/data/models/exercise_model.dart';
import 'package:workout_routine/features/routine/data/models/user_model.dart';

abstract class RoutineRepository {
  // Exercise
  Future<List<ExerciseModel>> getExercises({required int dayOfWeek});
  Future<void> addExercise({required ExerciseModel exercise});
  Future<void> removeExercise({required ExerciseModel exercise});
  Future<void> updateExercise({required ExerciseModel exercise});

  // User
  Future<UserModel> getUserInfo();
  Future<UserModel> updateUserInfo({required UserModel user});
}