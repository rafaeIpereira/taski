import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:taski/model/todo.dart';

class CreateScreen extends StatelessWidget {
  final Function(int) onNavigate;
  const CreateScreen({super.key, required this.onNavigate});

  static const color = Color(0xFF3F3D56);
  static const color2 = Color(0xFF8D9CBB);
  static const colorButton = Color(0xFF007FFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
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
                fontSize: 20, color: color, fontWeight: FontWeight.w600),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              'John',
              style: GoogleFonts.urbanist(
                textStyle: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w600, color: color),
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
                        color: color,
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
            padding: const EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              'Create tasks to achieve more.',
              style: GoogleFonts.urbanist(
                  textStyle: TextStyle(
                      fontSize: 18,
                      color: color2,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none)),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Column(
                spacing: 18,
                children: [
                  SvgPicture.asset(
                    'assets/svg/centerTask.svg',
                    fit: BoxFit.cover,
                    width: 100,
                  ),
                  Text(
                    'You have no task listed.',
                    style: GoogleFonts.urbanist(
                        color: color2,
                        decoration: TextDecoration.none,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      showModalBottomSheet(
                          backgroundColor: Colors.white,
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            final TextEditingController titleController =
                                TextEditingController();
                            final TextEditingController descriptionController =
                                TextEditingController();
                            return SizedBox(
                              height: 500,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50, top: 30),
                                    child: Row(
                                      spacing: 10,
                                      children: [
                                        SvgPicture.asset('assets/svg/box.svg'),
                                        Expanded(
                                          child: TextField(
                                            controller: titleController,
                                            maxLines: null,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    "What's in your mind?",
                                                hintStyle: GoogleFonts.urbanist(
                                                    textStyle: TextStyle(
                                                        fontSize: 18,
                                                        color: Color.fromRGBO(
                                                            198, 207, 220, 1),
                                                        fontWeight:
                                                            FontWeight.w500))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50, top: 20),
                                    child: Row(
                                      spacing: 10,
                                      children: [
                                        SvgPicture.asset('assets/svg/pen.svg'),
                                        Expanded(
                                          child: TextField(
                                            controller: descriptionController,
                                            maxLines: null,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Add a note..",
                                                hintStyle: GoogleFonts.urbanist(
                                                    textStyle: TextStyle(
                                                        fontSize: 18,
                                                        color: Color.fromRGBO(
                                                            198, 207, 220, 1),
                                                        fontWeight:
                                                            FontWeight.w500))),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 250, top: 70),
                                    child: TextButton(
                                      onPressed: () {
                                        String title =
                                            titleController.text.trim();
                                        String description =
                                            descriptionController.text.trim();

                                        if (title.isNotEmpty &&
                                            description.isNotEmpty) {
                                          var taskBox =
                                              Hive.box<Todo>('todoBox');
                                          taskBox.add(Todo(
                                              title: title,
                                              description: description));
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text(
                                        'Create',
                                        style: GoogleFonts.urbanist(
                                            color: Colors.blue,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).then((newTask) {
                        if (newTask != null) {
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context,
                              newTask); // Retorna os dados para o HomeScreen
                        }
                      })
                    },
                    style: ButtonStyle(
                        shadowColor: WidgetStateProperty.all<Color>(
                          Color.fromRGBO(0, 127, 255, 0.1),
                        ),
                        minimumSize: WidgetStateProperty.all(const Size(0, 60)),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12), // Remove o arredondamento
                          ),
                        )),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 5,
                      children: [
                        Icon(
                          Icons.add,
                          color: colorButton,
                        ),
                        Text(
                          'Create task',
                          style: GoogleFonts.urbanist(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: colorButton)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
