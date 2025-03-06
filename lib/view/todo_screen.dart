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
   late Box<Todo> todoBox;

  @override
  void initState() {
    super.initState();
    todoBox = Hive.box<Todo>('todoBox');
  }

  void _deleteTask(int index) {
    todoBox.deleteAt(index);
    setState(() {});
  }

  void _markTaskAsDone(int index) {
    final todo = todoBox.getAt(index);
    if (todo != null) {
      setState(() {
        todo.isCompleted = !todo.isCompleted; // Toggle the completion state
        todo.save();
      });

      // Show a snackbar with appropriate message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(todo.isCompleted
              ? 'Task marked as complete!'
              : 'Task marked as incomplete'),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: todo.isCompleted ? 'View Completed' : 'View Tasks',
            onPressed: () {
              widget.onNavigate(
                  todo.isCompleted ? 3 : 0); // Navigate to appropriate screen
            },
          ),
        ),
      );
    }
    // final todo = todoBox.getAt(index);
    // setState(() {
    // todo!.isCompleted = true;
    // todo.save();
    // });
    // widget.onNavigate(3);
  }

  void _editTask(int index) {
   final todo = todoBox.getAt(index);
    if (todo != null) {
      showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return EditTaskModal(
            initialTitle: todo.title,
            initialDescription: todo.description,
            onSave: (newTitle, newDescription) {
              todo.title = newTitle;
              todo.description = newDescription;
              todo.save();
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
              valueListenable: todoBox.listenable(),
              builder: (context, Box<Todo> box, _) {
                final incompleteTasks =
                    box.values.where((todo) => !todo.isCompleted).length;
                return Text(
                  box.isEmpty
                      ? 'Create tasks to achieve more.'
                      : "You’ve got $incompleteTasks tasks remaining.",
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
              valueListenable: todoBox.listenable(),
              builder: (context, Box<Todo> box, _) {
                final tasks = box.values.toList();

                if (tasks.isEmpty) {
                  return const Center(child: Text("No tasks yet"));
                }
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final todo = tasks[index];
                    if (!todo.isCompleted) {
                      // Only show incomplete tasks
                      return TodoCard(
                        title: todo.title,
                        description: todo.description,
                        onDelete: () async {
                          await box.delete(todo.key);
                        },
                        onEdit: () => _editTask(todo.key),
                        onMarkDone: () => _markTaskAsDone(index),
                        isDone: todo.isCompleted,
                      );
                    }
                    return SizedBox.shrink();
                  },
                );
              },
            ),)
        ],
      ),
    );
  }
}


