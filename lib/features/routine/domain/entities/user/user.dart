abstract class User {
  final int id;
  final String name;
  final DateTime firstWorkout;

  User({
    required this.id,
    required this.name,
    required this.firstWorkout
  });
}