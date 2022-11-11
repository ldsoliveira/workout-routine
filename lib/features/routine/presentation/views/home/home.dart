import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:workout_routine/core/theme/app_theme.dart';
import 'package:workout_routine/core/utils/app_log.dart';
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
    AppLog.log(className: 'Home', methodName: 'InitState', text: 'App initiated successfully.');

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
          title: Text('app-title'.i18n()),
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

                      AppLog.log(
                        className: 'Home',
                        methodName: 'onTap PopupMenuItem',
                        text: 'User tapped on uncheck exercises for '
                          '${BlocProvider.of<RoutineBloc>(context).dayOfWeek}'
                      );
                    },
                    child: Text('uncheck-exercises'.i18n()),
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
            AppLog.log(
              className: 'Home',
              methodName: 'onPressed FAB',
              text: 'User tapped add exercise FAB'
            );

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
