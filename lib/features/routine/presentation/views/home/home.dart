import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_routine/core/theme/app_theme.dart';
import 'package:workout_routine/core/utils/constants.dart';
import 'package:workout_routine/features/routine/data/models/exercise_model.dart';
import 'package:workout_routine/features/routine/presentation/bloc/routine_bloc.dart';
import 'package:workout_routine/features/routine/presentation/views/home/widgets/exercise_list_widget.dart';
import 'package:workout_routine/features/routine/presentation/views/home/widgets/weekdays_widget.dart';

import 'widgets/form_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ExerciseModel> _exercises = [];

  @override
  void initState() {
    super.initState();

    BlocProvider.of<RoutineBloc>(context).add(
      UpdateWeekdayIndexEvent(BlocProvider.of<RoutineBloc>(context).dayOfWeek)
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoutineBloc, RoutineState>(
      listener: (context, state) {
        if(state is UpdateWeekdayIndexState) {
          setState((){
            _exercises = state.exercises;
          });
        } else if(state is LoadedRoutinesState) {
          setState((){
            _exercises = state.exercises;
          });

          BlocProvider.of<RoutineBloc>(context).add(
              UpdateWeekdayIndexEvent(BlocProvider.of<RoutineBloc>(context).dayOfWeek)
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Workout routine'),
          actions: [
            PopupMenuButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    onTap: () {
                      BlocProvider.of<RoutineBloc>(context).add(
                        UncheckTodayExercisesEvent()
                      );
                    },
                    child: const Text('Uncheck today exercises'),
                  )
                ];
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: Constants.tagKey,
          backgroundColor: AppTheme.theme.primaryColor,
          elevation: 2,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, FormWidget.routeName);
          },
        ),
        body: Column(
          children: [
            const WeekDaysWidget(),
            ExerciseList(exercises: _exercises),
          ],
        ),
      ),
    );
  }
}
