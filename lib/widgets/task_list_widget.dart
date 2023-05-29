import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Provider/task_provider.dart';
import 'package:todoapp/widgets/task_item_widget.dart';

class TaskListWidget extends StatelessWidget {
  final bool completed;

  const TaskListWidget({Key? key, required this.completed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    final UnmodifiableListView taskItems =
        completed ? provider.completedTasks : provider.incompleteTasks;

    if (taskItems.isEmpty) {
      return Center(
        child: Text(completed
            ? "You haven't marked any tasks as completed"
            : "No tasks to show"),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemCount: taskItems.length,
      itemBuilder: (BuildContext context, int index) {
        return TaskItemWidget(
          task: taskItems[index],
        );
      },
    );
  }
}
