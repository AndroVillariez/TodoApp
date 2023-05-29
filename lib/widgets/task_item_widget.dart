import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Provider/task_provider.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/pages/task_editor_page.dart';
import 'package:todoapp/utils.dart';

class TaskItemWidget extends StatelessWidget {
  final Task task;

  const TaskItemWidget({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigateToTaskEditor(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskEditorPage(task: task),
        ),
      );
    }

    return GestureDetector(
      onTap: () => navigateToTaskEditor(context),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) => navigateToTaskEditor(context),
                backgroundColor: Colors.green,
                icon: Icons.edit,
                label: 'Edit',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  context.read<TaskProvider>().removeTask(task);
                  Utils.showSnackBar(context, "Task deleted");
                },
                backgroundColor: Colors.red,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Checkbox(
                  activeColor: Colors.teal,
                  checkColor: Colors.white,
                  value: task.isDone,
                  onChanged: (_) {
                    final provider = Provider.of<TaskProvider>(
                      context,
                      listen: false,
                    );
                    final isDone = provider.toggleTaskStatus(task);
                    Utils.showSnackBar(
                      context,
                      isDone
                          ? "Task marked as completed"
                          : "Task marked as incomplete",
                    );
                  },
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          fontSize: 18,
                        ),
                      ),
                      if (task.description.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          child: Text(
                            task.description,
                            style: const TextStyle(fontSize: 15.5, height: 1.3),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
