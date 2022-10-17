import 'package:workout_routine/features/routine/domain/entities/user/user.dart';

class UserModel implements User {
  UserModel({
    required this.id,
    required this.name,
    required this.firstWorkout,
  });

  @override
  final int id;
  @override
  final String name;
  @override
  final DateTime firstWorkout;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'firstWorkout': firstWorkout,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? DateTime.now().millisecondsSinceEpoch,
      name: map['name'] ?? '',
      firstWorkout: map['firstWorkout'] ?? DateTime.now(),
    );
  }
}
