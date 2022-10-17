import 'package:workout_routine/features/routine/data/models/exercise_model.dart';
import 'package:workout_routine/features/routine/data/models/user_model.dart';

abstract class LocalDataSource {
  // Exercise
  Future<List<ExerciseModel>> getAllExercises();
  Future<void> addExercise({required ExerciseModel exercise});
  Future<void> removeExercise({required ExerciseModel exercise});
  Future<void> updateExercise({required ExerciseModel exercise});

  // User
  Future<UserModel> getUserInfo();
  Future<UserModel> updateUserInfo({required UserModel user});
}