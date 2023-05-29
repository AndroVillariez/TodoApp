import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Provider/task_provider.dart';
import 'package:todoapp/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: const Color.fromARGB(255, 243, 243, 243),
        ),
        home: const HomePage(),
      ),
    );
  }
}
