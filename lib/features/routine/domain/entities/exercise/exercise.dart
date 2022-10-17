abstract class Exercise {
  final int id;
  final String name;
  final int repetitions;
  final int series;
  final int dayOfWeek;
  final bool done;

  Exercise({
    required this.id,
    required this.name,
    required this.repetitions,
    required this.series,
    required this.dayOfWeek,
    required this.done,
  });
}