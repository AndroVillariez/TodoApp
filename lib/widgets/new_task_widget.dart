import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Provider/task_provider.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/utils.dart';

class NewTaskWidget extends StatefulWidget {
  const NewTaskWidget({Key? key}) : super(key: key);

  @override
  State<NewTaskWidget> createState() => _NewTaskWidgetState();
}

class _NewTaskWidgetState extends State<NewTaskWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Title",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        TextField(
          maxLines: 1,
          controller: _titleController,
        ),
        const SizedBox(height: 8),
        Text(
          "Description",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.7),
          ),
        ),
        TextField(
          maxLines: 3,
          controller: _descriptionController,
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
            ),
            onPressed: () {
              final titleText = _titleController.text;
              final descriptionText = _descriptionController.text;

              if (titleText.isNotEmpty) {
                final newTask = Task(
                  title: titleText,
                  description: descriptionText,
                );
                context.read<TaskProvider>().addTask(newTask);

                Navigator.of(context).pop();
                Utils.showSnackBar(context, "Task saved");
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      "Please provide a title for the task",
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Back"),
                      ),
                    ],
                  ),
                );
              }
            },
            child: const Text("SAVE"),
          ),
        ),
      ],
    );
  }
}
