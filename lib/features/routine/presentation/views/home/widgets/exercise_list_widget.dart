import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_routine/core/theme/app_theme.dart';
import 'package:workout_routine/features/routine/data/models/exercise_model.dart';
import 'package:workout_routine/features/routine/presentation/bloc/routine_bloc.dart';

class ExerciseList extends StatefulWidget {
  const ExerciseList({
    Key? key,
    required this.exercises,
  }) : super(key: key);

  final List<ExerciseModel> exercises;

  @override
  State<ExerciseList> createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  @override
  Widget build(BuildContext context) {
    if(widget.exercises.isEmpty) {
      return _emptyListBuilder(context);
    }

    return Expanded(
      child: ListView.builder(
        itemCount: widget.exercises.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(widget.exercises[index].name),
            background: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(Icons.delete),
            ),
            confirmDismiss: (direction) async {
              return showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Really want to remove ${widget.exercises[index].name}?'),
                  content: const Text('This action can not be undone.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('CANCEL')
                    ),
                    TextButton(
                      onPressed: () {
                        BlocProvider.of<RoutineBloc>(context).add(
                          RemoveExerciseEvent(exercise: widget.exercises[index])
                        );

                        Navigator.of(context).pop();
                      },
                      child: const Text('OK')
                    ),
                  ],
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              elevation: 2,
              child: CheckboxListTile(
                value: widget.exercises[index].done,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                tileColor: AppTheme.theme.primaryColor.withOpacity(0.9),
                title: Text(
                  widget.exercises[index].name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ),
                subtitle: Text(
                  '${widget.exercises[index].series} series of ${widget.exercises[index].repetitions}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onChanged: (newValue) {
                  BlocProvider.of<RoutineBloc>(context).add(
                    UpdateDoneExerciseEvent(
                      exercise: widget.exercises[index],
                      isDone: newValue ?? false,
                    ),
                  );
                },
                activeColor: Colors.grey[400],
                checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _emptyListBuilder(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(5),
        color: AppTheme.theme.primaryColor.withOpacity(0.15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(10),
      child: const Text('No items has been added. Tap on the plus button on the right-bottom corner to add an exercise.'),
    );
  }
}
