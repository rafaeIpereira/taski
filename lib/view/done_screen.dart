import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taski/model/todo.dart';
import 'package:taski/widget/edit_task_modal.dart';
import 'package:taski/widget/todo_card.dart';

class DoneScreen extends StatefulWidget {
  final Function(int) onNavigate;

  const DoneScreen(
      {super.key, required this.onNavigate, required List completedTasks});

  @override
  // ignore: library_private_types_in_public_api
  _DoneScreenState createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  void _unmarkTask(Todo task) async {
    task.isCompleted = false;
    await task.save();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Task marked as incomplete'),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View Tasks',
          onPressed: () => widget.onNavigate(0), // Navigate to TodoScreen
        ),
      ),
    );
  }

  void _deleteTask(Box<Todo> box, Todo task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Task'),
        content: Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              box.delete(task.key);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Task deleted'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _editTask(Todo task) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return EditTaskModal(
        initialTitle: task.title,
        initialDescription: task.description,
        onSave: (newTitle, newDescription) async {
          if (newTitle.isNotEmpty && newDescription.isNotEmpty) {
            task.title = newTitle;
            task.description = newDescription;
            await task.save();
            
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Task updated successfully'),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Todo>('todoBox').listenable(),
      builder: (context, Box<Todo> box, _) {
        final completedTasks =
            box.values.where((task) => task.isCompleted).toList();

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
                    final task = completedTasks[index];
                    return TodoCard(
                      title: task.title,
                      description: task.description,
                      isDone: true,
                      onDelete: () => _deleteTask(box, task),
                      onEdit: () => _editTask(task), // Enable editing
                      onMarkDone: () => _unmarkTask(task),
                    );
                  },
                ),
        );
      },
    );
  }
}
