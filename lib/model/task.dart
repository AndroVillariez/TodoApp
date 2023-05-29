import 'package:uuid/uuid.dart';

class Task {
  bool isDone;
  String title;
  String description;
  final String uuid = const Uuid().v4();

  Task({required this.title, required this.description}) : isDone = false;

  @override
  bool operator ==(covariant Task other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;
}
