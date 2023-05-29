import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:todoapp/model/task.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(title: "Exercise", description: "Jog at 4 AM"),
    Task(title: "Study", description: "Final Exam tomorrow"),
    Task(title: "Feed the cat", description: "")
  ];

  UnmodifiableListView<Task> get incompleteTasks =>
      UnmodifiableListView(_tasks.where((task) => !task.isDone));

  UnmodifiableListView<Task> get completedTasks =>
      UnmodifiableListView(_tasks.where((task) => task.isDone));

  void _notifyListeners() => notifyListeners();

  void addTask(Task task) {
    _tasks.add(task);
    _notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    _notifyListeners();
  }

  bool toggleTaskStatus(Task task) {
    task.isDone = !task.isDone;
    _notifyListeners();
    return task.isDone;
  }

  void updateTask(Task task, String newTitle, String newDescription) {
    task.title = newTitle;
    task.description = newDescription;
    _notifyListeners();
  }
}


//Andro Edsarev S. Villariez

