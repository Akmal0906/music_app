import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_app/presentation/view/favorites_screen.dart';
import 'package:music_app/presentation/view/home_screen.dart';
import 'package:music_app/presentation/view/search_screen.dart';
import 'package:music_app/utlis/all_colors/all_color_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List<Widget> listWidgets = [
    const HomeScreen(),
    const SearchScreen(),
    const FavourScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: listWidgets[_currentIndex],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,

          buttonBackgroundColor: Colors.white70,
          color: Colors.white.withOpacity(0.9),
          items:  [
            const Icon(Icons.home,color: AllColors.backColor,),
            const  Icon(Icons.search,color: AllColors.backColor,),
            Icon(Icons.favorite,color: _currentIndex==2?Colors.red:AllColors.backColor,)
          ],
          onTap: (currentIndex) {
            setState(() {
              _currentIndex = currentIndex;
            });
          },
        ),
      ),
    );
  }
}




