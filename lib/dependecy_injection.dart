import 'package:get_it/get_it.dart';
import 'package:workout_routine/core/utils/app_database.dart';
import 'package:workout_routine/features/routine/data/datasources/local_datasource_impl.dart';
import 'package:workout_routine/features/routine/data/repositories/routine_repository_impl.dart';
import 'package:workout_routine/features/routine/domain/entities/exercise/exercise_dao.dart';
import 'package:workout_routine/features/routine/domain/entities/user/user_dao.dart';
import 'package:workout_routine/features/routine/domain/usecases/exercise_usecase.dart';
import 'package:workout_routine/features/routine/presentation/bloc/routine_bloc.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => RoutineBloc(
    sl(),
  ));

  // Usecases
  sl.registerLazySingleton(() => ExerciseUsecase(repository: sl()));

  // Repositories
  sl.registerLazySingleton<RoutineRepositoryImpl>(() => RoutineRepositoryImpl(
    sl(),
  ));

  // Dao
  sl.registerLazySingleton<ExerciseDao>(() => ExerciseDao());
  sl.registerLazySingleton<UserDao>(() => UserDao());

  // Externals
  final appDatabaseInstance = AppDatabase.instance;
  sl.registerLazySingleton(() => appDatabaseInstance);

  // Datasources
  sl.registerLazySingleton<LocalDataSourceImpl>(() => LocalDataSourceImpl(
    sl(),
    sl(),
  ));
}