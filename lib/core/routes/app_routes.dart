import 'package:flutter/material.dart';
import 'package:workout_routine/features/routine/presentation/views/home/home.dart';
import 'package:workout_routine/features/routine/presentation/views/home/widgets/form_widget.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const Home());
      case FormWidget.routeName:
        return _materialRoute(const FormWidget());

      default:
        return _materialRoute(const Home());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}