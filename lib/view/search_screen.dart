import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatelessWidget {
  final Function(int) onNavigate; 
  const SearchScreen({super.key, required this.onNavigate});

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
              padding: const EdgeInsets.only(right: 20, left: 20, top: 30),
              child: SearchBar(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: Color.fromRGBO(0, 127, 255,
                          0.5), // Define a cor azul para o OutlineBorder
                      width: 2.0, // Espessura da borda
                    ),
                  ),
                ),
                backgroundColor: WidgetStateProperty.all<Color>(
                  Color.fromRGBO(145, 173, 202, 0.098),
                ),
                shadowColor: WidgetStateProperty.all<Color>(
                  Color.fromRGBO(0, 127, 255, 0.0),
                ),
                leading: SvgPicture.asset(
                  'assets/svg/search.svg',
                  width: 20,
                  colorFilter: ColorFilter.mode(colorButton, BlendMode.srcIn),
                ),
                trailing: [
                  Icon(Icons.highlight_remove, color: Colors.grey, size: 24.0),
                ],
                hintText: 'Search taski..',
                hintStyle: WidgetStateProperty.all(GoogleFonts.urbanist(
                    textStyle: TextStyle(
                        fontSize: 16,
                        color: color2,
                        fontWeight: FontWeight.w500))),
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
                      'No result found.',
                      style: GoogleFonts.urbanist(
                          color: color2,
                          decoration: TextDecoration.none,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 4,
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
