import 'package:workout_routine/features/routine/data/datasources/local_datasource.dart';
import 'package:workout_routine/features/routine/data/models/exercise_model.dart';
import 'package:workout_routine/features/routine/data/models/user_model.dart';
import 'package:workout_routine/features/routine/domain/entities/exercise/exercise.dart';
import 'package:workout_routine/features/routine/domain/entities/exercise/exercise_dao.dart';
import 'package:workout_routine/features/routine/domain/entities/user/user_dao.dart';

class LocalDataSourceImpl implements LocalDataSource {
  final ExerciseDao _exerciseDao;
  final UserDao _userDao;

  LocalDataSourceImpl(this._exerciseDao, this._userDao);

  // Exercise
  @override
  Future<void> addExercise({required ExerciseModel exercise}) async {
    await _exerciseDao.insertExercise(exercise);
  }

  @override
  Future<void> removeExercise({required Exercise exercise}) async {
    await _exerciseDao.removeExercise(exercise);
  }

  @override
  Future<List<ExerciseModel>> getAllExercises() async {
    return await _exerciseDao.getAllExercises();
  }

  @override
  Future<void> updateExercise({required ExerciseModel exercise}) async {
    await _exerciseDao.updateExercise(exercise);
  }

  // User
  @override
  Future<UserModel> getUserInfo() async {
    return await _userDao.getUser();
  }

  @override
  Future<UserModel> updateUserInfo({required UserModel user}) async {
    return await _userDao.updateUser(user);
  }

}