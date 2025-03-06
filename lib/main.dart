import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taski/model/todo.dart';
import 'package:taski/view/home_screen.dart';


void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TodoAdapter());

  await Hive.openBox<Todo>('todoBox');

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: CupertinoColors.activeBlue,
        textTheme: GoogleFonts.urbanistTextTheme(
          Theme.of(context).textTheme
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
