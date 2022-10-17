import 'package:workout_routine/features/routine/data/datasources/local_datasource_impl.dart';
import 'package:workout_routine/features/routine/data/models/exercise_model.dart';
import 'package:workout_routine/features/routine/data/models/user_model.dart';
import 'package:workout_routine/features/routine/domain/entities/exercise/exercise.dart';
import 'package:workout_routine/features/routine/domain/repositories/routine_repository.dart';

class RoutineRepositoryImpl implements RoutineRepository {
  final LocalDataSourceImpl _localDataSource;

  RoutineRepositoryImpl(this._localDataSource);

  // Exercise
  @override
  Future<void> addExercise({required ExerciseModel exercise}) async {
    await _localDataSource.addExercise(exercise: exercise);
  }

  @override
  Future<void> removeExercise({required Exercise exercise}) async {
    await _localDataSource.removeExercise(exercise: exercise);
  }

  @override
  Future<List<ExerciseModel>> getExercises({required int dayOfWeek}) async {
    final exercises = await _localDataSource.getAllExercises();
    return exercises.where((exercise) => exercise.dayOfWeek == dayOfWeek).toList();
  }

  @override
  Future<void> updateExercise({required ExerciseModel exercise}) async {
    await _localDataSource.updateExercise(exercise: exercise);
  }

  // User
  @override
  Future<UserModel> getUserInfo() async {
    return await _localDataSource.getUserInfo();
  }

  @override
  Future<UserModel> updateUserInfo({required UserModel user}) async {
    return await _localDataSource.updateUserInfo(user: user);
  }

}