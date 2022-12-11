import 'package:flutter/material.dart';
import 'package:games_project/favouriteProvider.dart';
import 'favourites.dart';
import 'games.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const GameProject());
}

class GameProject extends StatefulWidget {
  const GameProject({Key? key}) : super(key: key);

  @override
  State<GameProject> createState() => _GameProjectState();
}

class _GameProjectState extends State<GameProject> {
  int _selectedIndex = 0;

  void onItemTapped(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOption = <Widget>[
    Games(),
    Favourites(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavouriteProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            child: _widgetOption.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/icons/gameIcon.png',
                    height: 30,
                    color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
                  ),
                  label: 'Games'),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.star, size: 30), label: 'Favourites')
            ],
            currentIndex: _selectedIndex,
            onTap: onItemTapped,
            selectedFontSize: 15,
            unselectedFontSize: 15,
            selectedIconTheme: const IconThemeData(color: Colors.blue),
            unselectedIconTheme: const IconThemeData(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
