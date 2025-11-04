import 'package:fitness_tracker/enums/workout_type.dart';
import 'package:fitness_tracker/providers/workout/workout_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WorkoutFormDialog extends StatefulHookConsumerWidget {
  const WorkoutFormDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WorkoutFormDailogState();
}

class _WorkoutFormDailogState extends ConsumerState<WorkoutFormDialog> {
  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final nameController = useTextEditingController();
    final weightController = useTextEditingController();
    final repsController = useTextEditingController();
    final setsController = useTextEditingController();
    final selectedType = useState<WorkoutType>(WorkoutType.lowerBody);

    void submit() {
      if (formKey.currentState?.validate() ?? false) {
        ref.read(workoutNotifierProvider.notifier).addWorkout(
              nameController.text,
              double.parse(weightController.text),
              int.parse(repsController.text),
              int.parse(setsController.text),
              selectedType.value,
            );
        Navigator.of(context).pop();
      }
    }

    return Expanded(
      child: AlertDialog(
        title: const Text('Add Workout'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //form fields
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter a name' : null,
              ),
              TextFormField(
                controller: weightController,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter weight' : null,
              ),
              TextFormField(
                controller: repsController,
                decoration: const InputDecoration(labelText: 'Reps'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter reps' : null,
              ),
              TextFormField(
                controller: setsController,
                decoration: const InputDecoration(labelText: 'Sets'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter sets' : null,
              ),
              const SizedBox(height: 16),

              //dropdown for workout type
              DropdownButtonFormField<WorkoutType>(
                items: const [
                  DropdownMenuItem(
                    value: WorkoutType.upperBody,
                    child: Text('Upper Body'),
                  ),
                  DropdownMenuItem(
                    value: WorkoutType.lowerBody,
                    child: Text('Lower Body'),
                  ),
                ],
                initialValue: selectedType.value,
                onChanged: (value) {
                  if (value != null) {
                    selectedType.value = value;
                  }
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(onPressed: submit, child: const Text('Add')),
        ],
      ),
    );
  }
}
