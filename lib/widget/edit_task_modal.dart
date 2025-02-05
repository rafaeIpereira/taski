import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EditTaskModal extends StatefulWidget {
  final String initialTitle;
  final String initialDescription;
  final Function(String, String) onSave;

  const EditTaskModal({
    super.key,
    required this.initialTitle,
    required this.initialDescription,
    required this.onSave,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EditTaskModalState createState() => _EditTaskModalState();
}

class _EditTaskModalState extends State<EditTaskModal> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descriptionController =
        TextEditingController(text: widget.initialDescription);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.only(left: 50, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 10,
              children: [
                SvgPicture.asset('assets/svg/box.svg'),
                Expanded(
                  child: TextField(
                    style: GoogleFonts.urbanist(textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300,)),
                    controller: _titleController,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "What's in your mind?",
                      hintStyle: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(198, 207, 220, 1),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15,),
            Row(
              spacing: 10,
              children: [
                SvgPicture.asset('assets/svg/pen.svg'),
                Expanded(
                  child: TextField(
                    style: GoogleFonts.urbanist(textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w300,)),
                    controller: _descriptionController,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add a note..",
                      hintStyle: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(198, 207, 220, 1),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 250, top: 70),
              child: TextButton(
                onPressed: () {
                   widget.onSave(_titleController.text, _descriptionController.text);
                  Navigator.pop(context);
                },
                child: Text(
                  'Save',
                  style: GoogleFonts.urbanist(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
