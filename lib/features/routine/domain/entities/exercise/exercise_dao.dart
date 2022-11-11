import 'package:sembast/sembast.dart';
import 'package:workout_routine/core/utils/app_database.dart';
import 'package:workout_routine/core/utils/constants.dart';
import 'package:workout_routine/features/routine/data/models/exercise_model.dart';
import 'package:workout_routine/features/routine/domain/entities/exercise/exercise.dart';

class ExerciseDao {
  final _exercisesFolder = intMapStoreFactory.store(Constants.dbExerciseFolderName);

  Future<Database> get _db async => AppDatabase.instance.db;

  Future insertExercise(ExerciseModel exercise) async {
    await _exercisesFolder.add(await _db, exercise.toJson());
  }

  Future updateExercise(ExerciseModel exercise) async {
    final finder = Finder(filter: Filter.equals('id', exercise.id));
    await _exercisesFolder.update(await _db, exercise.toJson(), finder: finder);
  }

  Future removeExercise(Exercise exercise) async {
    final finder = Finder(filter: Filter.equals('id', exercise.id));
    await _exercisesFolder.delete(await _db, finder: finder);
  }

  Future<List<ExerciseModel>> getAllExercises() async {
    final recordSnapshot = await _exercisesFolder.find(await _db);
    return recordSnapshot.map((snapshot) {
      return ExerciseModel.fromJson(snapshot.value);
    }).toList();
  }
}