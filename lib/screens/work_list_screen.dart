import 'package:fitness_tracker/enums/workout_type.dart';
import 'package:fitness_tracker/providers/workout/workout_provider.dart';
import 'package:fitness_tracker/widgets/workout_form_dialog.dart';
import 'package:fitness_tracker/widgets/workout_calender_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkListScreen extends StatefulWidget {
  const WorkListScreen({super.key});

  @override
  State<WorkListScreen> createState() => _WorkListScreenState();
}

class _WorkListScreenState extends State<WorkListScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        //todo
        //final workouts = ref.watch(workoutNotifierProvider);
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const SizedBox.shrink(),
              toolbarHeight: 170,
              flexibleSpace: const SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        EdgeInsets.only(bottom: 56.0, left: 16.0, right: 16.0),
                    child: WorkoutCalenderGraph(),
                  ),
                ),
              ),
              bottom: const PreferredSize(
                preferredSize: Size.fromHeight(48),
                child: TabBar(
                  tabs: [
                    Tab(text: 'Upper Body'),
                    Tab(text: 'Lower Body'),
                  ],
                ),
              ),
            ),
            body: const TabBarView(
              children: [
                _WorkoutList(type: WorkoutType.upperBody),
                _WorkoutList(type: WorkoutType.lowerBody),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showAddWorkoutDialog(context),
              child: const Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }

  void _showAddWorkoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const WorkoutFormDialog(),
    );
  }
}

//workout list widget
class _WorkoutList extends ConsumerWidget {
  final WorkoutType type;

  const _WorkoutList({required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unfilteredWorkouts = ref.watch(workoutNotifierProvider);
    final workouts =
        unfilteredWorkouts.where((workout) => workout.type == type).toList();

//display no workout message
    if (workouts.isEmpty) {
      return const Center(
        child: Text(
          'No workouts added yet.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Total Workouts: ${workouts.length}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return Card(
                child: ListTile(
                  enabled: false,
                  title: Text(
                    workout.name,
                    style: TextStyle(
                        decoration: workout.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color:
                            workout.isCompleted ? Colors.grey : Colors.white),
                  ),
                  subtitle: Text(
                    '${workout.sets} sets',
                    style: TextStyle(
                      decoration: workout.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: workout.isCompleted ? Colors.grey : Colors.white,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                          value: workout.isCompleted,
                          onChanged: (_) {
                            ref
                                .read(workoutNotifierProvider.notifier)
                                .toggleWorkoutStatus(workout.id);
                          }),
                      IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            ref
                                .read(workoutNotifierProvider.notifier)
                                .deleteWorkout(workout.id);
                          }),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
