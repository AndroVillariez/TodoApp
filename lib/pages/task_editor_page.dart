import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Provider/task_provider.dart';
import 'package:todoapp/model/task.dart';
import 'package:todoapp/utils.dart';

class TaskEditorPage extends StatefulWidget {
  final Task task;

  const TaskEditorPage({super.key, required this.task});

  @override
  State<TaskEditorPage> createState() => _TaskEditorPageState();
}

class _TaskEditorPageState extends State<TaskEditorPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void deleteTask(BuildContext context) {
    Provider.of<TaskProvider>(context, listen: false).removeTask(widget.task);
    Navigator.of(context).pop();
    Utils.showSnackBar(context, "Task deleted");
  }

  void saveTask(BuildContext context) {
    final titleText = _titleController.text;
    final descriptionText = _descriptionController.text;

    if (titleText.isNotEmpty) {
      Provider.of<TaskProvider>(context, listen: false)
          .updateTask(widget.task, titleText, descriptionText);
      Navigator.of(context).pop();
      Utils.showSnackBar(context, "Your changes have been saved");
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(
            "Please provide a title for the task",
            style: TextStyle(
              color: Colors.teal,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Back"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Task"),
        actions: [
          IconButton(
              onPressed: () => deleteTask(context),
              icon: const Icon(Icons.delete),
              color: const Color.fromARGB(255, 239, 86, 75)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Title",
              style:
                  TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.7)),
            ),
            TextField(
              maxLines: 1,
              controller: _titleController,
            ),
            const SizedBox(height: 8),
            Text(
              "Description",
              style:
                  TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.7)),
            ),
            TextField(
              maxLines: 3,
              controller: _descriptionController,
            ),
            const SizedBox(height: 25),
            SizedBox(
              height: 34,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal),
                ),
                onPressed: () => saveTask(context),
                child: const Text(
                  "SAVE",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
