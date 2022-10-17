import 'package:workout_routine/features/routine/domain/entities/exercise/exercise.dart';

class ExerciseModel implements Exercise {
  ExerciseModel({
    required this.id,
    required this.name,
    required this.repetitions,
    required this.series,
    required this.dayOfWeek,
    required this.done,
  });

  @override
  final int id;
  @override
  final String name;
  @override
  final int repetitions;
  @override
  final int series;
  @override
  final int dayOfWeek;
  @override
  final bool done;

  factory ExerciseModel.fromJson(Map<String, dynamic> map) {
    return ExerciseModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      repetitions: map['repetitions'] ?? 0,
      series: map['series'] ?? 0,
      dayOfWeek: map['dayOfWeek'] ?? 0,
      done: map['done'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'repetitions': repetitions,
    'series': series,
    'dayOfWeek': dayOfWeek,
    'done': done,
  };

  ExerciseModel copyWith({
    int? id,
    String? name,
    int? repetitions,
    int? series,
    int? dayOfWeek,
    bool? done,
  }) {
    return ExerciseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      repetitions: repetitions ?? this.repetitions,
      series: series ?? this.series,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      done: done ?? this.done,
    );
  }

}
