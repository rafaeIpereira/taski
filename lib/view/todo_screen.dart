import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taski/model/todo.dart';
import 'package:taski/widget/todo_card.dart';
import 'package:taski/widget/edit_task_modal.dart'; // Import do modal de edição

class TodoScreen extends StatefulWidget {
  
  final Function(int) onNavigate; 
  const TodoScreen({super.key, required this.onNavigate});

  static const color = Color(0xFF3F3D56);
  static const color2 = Color(0xFF8D9CBB);
  static const colorButton = Color(0xFF007FFF);

  @override
  State<TodoScreen> createState() => _TodoScreenState();

}

class _TodoScreenState extends State<TodoScreen> {
   late Box<Todo> tasksBox;

  @override
  void initState() {
    super.initState();
    tasksBox = Hive.box<Todo>('todoBox');
  }

  void _deleteTask(int index) {
    tasksBox.deleteAt(index);
    setState(() {});
  }

  void _markTaskAsDone(int index) {
    final task = tasksBox.getAt(index);
    task!.isCompleted = true;
    
    task.save();
    setState(() {});

    widget.onNavigate(3);
  }

  void _editTask(int index) {
   final task = tasksBox.getAt(index);
    if (task != null) {
      showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return EditTaskModal(
            initialTitle: task.title,
            initialDescription: task.description,
            onSave: (newTitle, newDescription) {
              task.title = newTitle;
              task.description = newDescription;
              task.save();
            },
          );
        },
      );
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Icon(
            Icons.check_box_rounded,
            color: Colors.blue,
            size: 40,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            'Taski',
            style: GoogleFonts.urbanist(
              fontSize: 20,
              color: TodoScreen.color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              'John',
              style: GoogleFonts.urbanist(
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: TodoScreen.color),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage('assets/avatar.jpg'),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 30, bottom: 5),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Welcome, ',
                    style: GoogleFonts.urbanist(
                      textStyle: TextStyle(
                        color: TodoScreen.color,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: 'John.',
                    style: GoogleFonts.urbanist(
                      textStyle: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ValueListenableBuilder(
              valueListenable: tasksBox.listenable(),
              builder: (context, Box<Todo> box, _) {
                return Text(
                  box.isEmpty
                      ? 'Create tasks to achieve more.'
                      : "You’ve got ${box.length} tasks to do.",
                  style: GoogleFonts.urbanist(
                    fontSize: 18,
                    color: TodoScreen.color2,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
          ),
         Expanded(
            child: ValueListenableBuilder(
              valueListenable: tasksBox.listenable(),
              builder: (context, Box<Todo> box, _) {
                if (box.isEmpty) {
                  return const Center(child: Text("No tasks yet"));
                }
                return ListView.builder(
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    final task = box.getAt(index)!;
                    return TodoCard(
                      title: task.title,
                      description: task.description,
                      onDelete: () => _deleteTask(index),
                      onEdit: () => _editTask(index),
                      onMarkDone: () => _markTaskAsDone(index),
                    );
                  },
                );
              },
            ),)
        ],
      ),
    );
  }
}


