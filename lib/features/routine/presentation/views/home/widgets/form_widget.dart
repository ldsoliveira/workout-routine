import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => _validator(value),
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _repsController,
                  label: 'Num. of reps',
                ),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: _seriesController,
                  label: 'Num. of series',
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
                        style: AppTheme.textStyle.copyWith(
                          color: Colors.grey[600],
                        ),
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

  TextFormField _buildTextField({required TextEditingController controller, required String label}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        border: const OutlineInputBorder(),
      ),
      textInputAction: controller == _seriesController
          ? TextInputAction.done
          : TextInputAction.next,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: false,
        signed: false,
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) => _validator(value),
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
