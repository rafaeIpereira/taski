import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:taski/widget/todo_card.dart';

class DoneScreen extends StatefulWidget {
  final Function(int) onNavigate;

  const DoneScreen({super.key, required this.onNavigate, required List completedTasks});

  @override
  // ignore: library_private_types_in_public_api
  _DoneScreenState createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  late Box<Map<dynamic, dynamic>> taskBox;

  @override
  void initState() {
    super.initState();
    taskBox = Hive.box('tasks');
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> completedTasks = taskBox.values
        .where((task) => task['isDone'] == true)
        .toList()
        .cast<Map<String, dynamic>>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Tarefas Concluídas',
          style: GoogleFonts.urbanist(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: completedTasks.isEmpty
          ? Center(
              child: Text(
                'Nenhuma tarefa concluída.',
                style: GoogleFonts.urbanist(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                final taskKey = taskBox.keys.elementAt(index);
                return TodoCard(
                  title: completedTasks[index]['title'],
                  description: completedTasks[index]['description'],
                  onDelete: () {
                    setState(() {
                      taskBox.delete(taskKey);
                    });
                  },
                  onEdit: () {}, // Edição pode ser adicionada depois
                  onMarkDone: () {}, // Já está concluído
                  isDone: true,
                );
              },
            ),
    );
  }
}
