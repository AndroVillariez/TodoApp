import 'package:flutter/material.dart';
import 'package:todoapp/widgets/new_task_widget.dart';
import 'package:todoapp/widgets/task_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentTab = 0;

  final List<Widget> tabs = [
    const TaskListWidget(completed: false),
    const TaskListWidget(completed: true),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentTab == 0 ? "To-Do List" : "Completed Tasks"),
      ),
      body: tabs[currentTab],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => const AlertDialog(
              title: Text(
                "Add a task to your list",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.teal),
              ),
              content: NewTaskWidget(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 145, 145, 145),
        selectedItemColor: Colors.teal,
        currentIndex: currentTab,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: "To-Dos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: "Completed",
          ),
        ],
      ),
    );
  }
}
