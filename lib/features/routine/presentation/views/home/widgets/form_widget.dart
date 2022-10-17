import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_routine/core/theme/app_theme.dart';
import 'package:workout_routine/core/utils/constants.dart';
import 'package:workout_routine/features/routine/presentation/bloc/routine_bloc.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({
    Key? key,
  }) : super(key: key);

  static const routeName = '/form_widget';

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _nameController = TextEditingController();
  final _repsController = TextEditingController();
  final _seriesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: Constants.tagKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add exercise form'),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => _validator(value),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _repsController,
                  decoration: const InputDecoration(
                    label: Text('Num. of reps'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => _validator(value),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _seriesController,
                  decoration: const InputDecoration(
                    label: Text('Num. of series'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => _validator(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: AppTheme.textStyle,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if(_formKey.currentState?.validate() ?? false) {
                          BlocProvider.of<RoutineBloc>(context).add(
                            AddExerciseEvent(
                              name: _nameController.text,
                              reps: int.tryParse(_repsController.text)!,
                              series: int.tryParse(_seriesController.text)!,
                            ),
                          );

                          Navigator.of(context).pop();
                        }

                        return;
                      },
                      child: Text(
                        'Add exercise',
                        style: AppTheme.textStyle,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validator(String? value) {
    if(value == null || value.isEmpty) {
      return 'Required field';
    }

    return null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _repsController.dispose();
    _seriesController.dispose();

    super.dispose();
  }
}
