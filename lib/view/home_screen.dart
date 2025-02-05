import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taski/view/create_screen.dart';
import 'package:taski/view/done_screen.dart';
import 'package:taski/view/search_screen.dart';
import 'package:taski/view/todo_screen.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const colorButton = Color(0xFF007FFF);

  int _currentIndex = 0;

  void _navigateTo(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _pages = [];
  
  @override
  void initState() {
    super.initState();
    _pages.addAll([
      TodoScreen(onNavigate: _navigateTo),
      CreateScreen(onNavigate: _navigateTo),
      SearchScreen(onNavigate: _navigateTo),
      DoneScreen(completedTasks: [], onNavigate: _navigateTo),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex, // Mostra a página atual
        children: _pages,
      ), // Renderiza a página atual com base no índice
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Define o item selecionado
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Atualiza o índice ao clicar em uma aba
          });
        },
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.urbanist(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.blue),
        ),
        unselectedLabelStyle: GoogleFonts.urbanist(
          textStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(198, 207, 220, 1),
          ),
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/todo.svg',
              width: 30,
              colorFilter: ColorFilter.mode(
                _currentIndex == 0
                    ? colorButton
                    : const Color.fromRGBO(198, 207, 220, 1),
                BlendMode.srcIn,
              ),
            ),
            label: 'Todo',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/plus.svg',
              width: 30,
              colorFilter: ColorFilter.mode(
                _currentIndex == 1
                    ? colorButton
                    : const Color.fromRGBO(198, 207, 220, 1),
                BlendMode.srcIn,
              ),
            ),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/search.svg',
              width: 30,
              colorFilter: ColorFilter.mode(
                _currentIndex == 2
                    ? colorButton
                    : const Color.fromRGBO(198, 207, 220, 1),
                BlendMode.srcIn,
              ),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg/checked-.svg',
              width: 30,
              colorFilter: ColorFilter.mode(
                _currentIndex == 3
                    ? colorButton
                    : const Color.fromRGBO(198, 207, 220, 1),
                BlendMode.srcIn,
              ),
            ),
            label: 'Done',
          ),
        ],
      ),
    );
  }
}
