//add workout
//toggleWorkoutStatus
//delete workout

import 'package:fitness_tracker/enums/workout_type.dart';
import 'package:fitness_tracker/models/workout.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'workout_provider.g.dart';

@riverpod
class WorkoutNotifier extends _$WorkoutNotifier {
  final _uuid = const Uuid();
  @override
  List<Workout> build() {
    //initially return empty list
    return [];
  }

  void addWorkout(
      String name, double weight, int reps, int sets, WorkoutType type) {
    final workout = Workout(
      id: _uuid.v4(),
      name: name,
      weight: weight,
      reps: reps,
      sets: sets,
      isCompleted: false,
      type: type,
    );
    state = [...state, workout];
  }

  void toggleWorkoutStatus(String id) {
    state = [
      for (final workout in state)
        if (workout.id == id)
          workout.copyWith(isCompleted: !workout.isCompleted)
        else
          workout
    ];
  }

  void deleteWorkout(String id) {
    state = state.where((workout) => workout.id != id).toList();
  }
}
