import 'package:workout_routine/features/routine/data/models/user_model.dart';
import 'package:workout_routine/features/routine/data/repositories/routine_repository_impl.dart';

class UpdateUserInfo {
  const UpdateUserInfo({
    required this.repository,
  });

  final RoutineRepositoryImpl repository;

  Future<UserModel> call({required UserModel user}) => repository.updateUserInfo(user: user);
}