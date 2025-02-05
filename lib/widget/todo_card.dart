import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onMarkDone;
  final bool isDone;

  const TodoCard({
    super.key,
    required this.title,
    required this.description,
    required this.onEdit,
    required this.onDelete,
    required this.onMarkDone,
    this.isDone = false, // Define se a tarefa está concluída
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(title),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.red),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onDelete();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Card(
          color: const Color.fromRGBO(245, 247, 249, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListTile(
            leading: GestureDetector(
              onTap: onMarkDone,
              child: SvgPicture.asset(
                isDone ? 'assets/svg/checked.svg' : 'assets/svg/box.svg',
                height: 24,
                width: 24,
              ),
            ),
            title: Text(
              title,
              style: GoogleFonts.urbanist(
                  fontSize: 18, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              description,
              style: GoogleFonts.urbanist(fontSize: 16, color: Colors.grey),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
          ),
        ),
      ),
    );
  }
}

