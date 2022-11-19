import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:workout_routine/core/theme/app_theme.dart';
import 'package:workout_routine/core/utils/app_log.dart';
import 'package:workout_routine/features/routine/presentation/bloc/routine_bloc.dart';

class WeekDaysWidget extends StatefulWidget {
  const WeekDaysWidget({Key? key}) : super(key: key);

  @override
  State<WeekDaysWidget> createState() => _WeekDaysWidgetState();
}

class _WeekDaysWidgetState extends State<WeekDaysWidget> {
  final _controller = ScrollController();
  int _selectedIndex = DateTime.now().weekday;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(_controller.hasClients && _selectedIndex >= 4) {
        _controller.animateTo(
          _controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String _buildTitle(int index) {
      switch(index) {
        case 1:
          return 'weekday-monday'.i18n();
        case 2:
          return 'weekday-tuesday'.i18n();
        case 3:
          return 'weekday-wednesday'.i18n();
        case 4:
          return 'weekday-thursday'.i18n();
        case 5:
          return 'weekday-friday'.i18n();
        case 6:
          return 'weekday-saturday'.i18n();
        case 7:
          return 'weekday-sunday'.i18n();
        default:
          return 'weekday-monday'.i18n();
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _controller,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: List.generate(7, (index) {
            return TextButton(
              style: ButtonStyle(
                backgroundColor: index == _selectedIndex
                    ? MaterialStateProperty.all(Colors.grey[300])
                    : null,
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

                BlocProvider.of<RoutineBloc>(context)
                    .add(UpdateWeekdayIndexEvent(index));

                AppLog.log(
                    className: 'WeekDaysWidget',
                    methodName: 'onPressed Weekday',
                    text: 'User changed selected weekday to ${_buildTitle(index)} successfully'
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
