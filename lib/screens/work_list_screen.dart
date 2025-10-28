import 'package:fitness_tracker/enums/workout_type.dart';
import 'package:fitness_tracker/widgets/workout_form_dialog.dart';
import 'package:flutter/material.dart';

class WorkListScreen extends StatefulWidget {
  const WorkListScreen({super.key});

  @override
  State<WorkListScreen> createState() => _WorkListScreenState();
}

class _WorkListScreenState extends State<WorkListScreen> {
  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.only(bottom: 56.0, left: 16.0, right: 16.0),
                // child: WorkoutCalendarGraph(),
                child: Text('Workout Calendar Graph Placeholder'),
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
  }

  void _showAddWorkoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const WorkoutFormDialog(),
    );
  }
}

//workout list widget

class _WorkoutList extends StatelessWidget {
  final WorkoutType type;

  const _WorkoutList({required this.type});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            enabled: false,
            title: const Text(
              "workout 1",
              style: TextStyle(color: Colors.grey),
            ),
            subtitle: const Text(
              '1 sets',
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(value: false, onChanged: (_) {}),
                IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
              ],
            ),
          ),
        );
      },
    );
  }
}
