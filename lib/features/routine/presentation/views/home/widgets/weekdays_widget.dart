import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_routine/core/theme/app_theme.dart';
import 'package:workout_routine/features/routine/presentation/bloc/routine_bloc.dart';

class WeekDaysWidget extends StatefulWidget {
  const WeekDaysWidget({Key? key}) : super(key: key);

  @override
  State<WeekDaysWidget> createState() => _WeekDaysWidgetState();
}

class _WeekDaysWidgetState extends State<WeekDaysWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    String _buildTitle(int index) {
      switch(index) {
        case 0:
          return 'Monday';
        case 1:
          return 'Tuesday';
        case 2:
          return 'Wednesday';
        case 3:
          return 'Thursday';
        case 4:
          return 'Friday';
        case 5:
          return 'Saturday';
        case 6:
          return 'Sunday';
        default:
          return 'Monday';
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: List.generate(7, (index) {
            return TextButton(
              style: ButtonStyle(
                backgroundColor: index == _selectedIndex ? MaterialStateProperty.all(Colors.grey[300]) : null,
                overlayColor: MaterialStateProperty.all(Colors.green[200])
              ),
              child: Text(
                _buildTitle(index),
                style: AppTheme.textStyle,
              ),
              onPressed: () {
                setState(() {
                  _selectedIndex = index;
                });

                BlocProvider.of<RoutineBloc>(context).add(UpdateWeekdayIndexEvent(index));
              },
            );
          }),
        ),
      ),
    );
  }
}
