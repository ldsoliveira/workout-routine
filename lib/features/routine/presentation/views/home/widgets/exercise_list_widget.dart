import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:workout_routine/core/theme/app_theme.dart';
import 'package:workout_routine/core/utils/app_log.dart';
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
              AppLog.log(
                className: 'ExerciseList',
                methodName: 'Dismiss Exercise',
                text: 'User dismissed the exercise ${widget.exercises[index]}'
              );

              return showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('remove-dialog-title'.i18n([widget.exercises[index].name])),
                  content: Text('remove-dialog-content'.i18n()),
                  actions: [
                    TextButton(
                      onPressed: () {
                        AppLog.log(
                            className: 'ExerciseList',
                            methodName: 'Confirmation dialog',
                            text: 'User canceled the removal of the exercise ${widget.exercises[index]}'
                        );

                        Navigator.pop(context);
                      },
                      child: Text('remove-dialog-cancel'.i18n().toUpperCase())
                    ),
                    TextButton(
                      onPressed: () {
                        AppLog.log(
                            className: 'ExerciseList',
                            methodName: 'Confirmation dialog',
                            text: 'User removed the exercise ${widget.exercises[index]}'
                        );

                        BlocProvider.of<RoutineBloc>(context).add(
                          RemoveExerciseEvent(exercise: widget.exercises[index])
                        );

                        Navigator.of(context).pop();
                      },
                      child: Text('remove-dialog-accept'.i18n().toUpperCase())
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
                  'list-subtitle'.i18n([
                    widget.exercises[index].series.toString(),
                    widget.exercises[index].repetitions.toString()
                  ]),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                onChanged: (newValue) {
                  AppLog.log(
                      className: 'ExerciseList',
                      methodName: 'onChanged Check Exercise',
                      text: 'User checked the exercise ${widget.exercises[index]}'
                  );

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
      child: Text('empty-list'.i18n()),
    );
  }
}
