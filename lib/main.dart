import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_routine/core/routes/app_routes.dart';
import 'package:workout_routine/core/theme/app_theme.dart';
import 'package:workout_routine/dependecy_injection.dart' as di;
import 'package:workout_routine/features/routine/presentation/bloc/routine_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RoutineBloc(di.sl()),
        ),
      ],
      child: MaterialApp(
        title: 'Workout Routine',
        theme: AppTheme.theme,
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        initialRoute: '/',
      ),
    );
  }
}