import 'package:workout_routine/features/routine/data/repositories/routine_repository_impl.dart';
import 'package:workout_routine/features/routine/domain/entities/user/user.dart';

class GetUserInfo {
  const GetUserInfo({
    required this.repository,
  });

  final RoutineRepositoryImpl repository;

  Future<User> call() => repository.getUserInfo();
}