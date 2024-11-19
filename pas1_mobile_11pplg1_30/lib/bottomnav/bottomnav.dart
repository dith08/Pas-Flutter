import 'package:flutter/material.dart';
import 'package:pas1_mobile_11pplg1_30/sport/sport_view.dart';
import 'package:pas1_mobile_11pplg1_30/sportfavorit/sportfavorit_view.dart';
import 'package:pas1_mobile_11pplg1_30/profile/profile_view.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _halaman = [
    TeamView(),
    FavoriteView(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _halaman[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.blue[900],
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blue[300],
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.sports_basketball),
              label: 'Tim',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorit',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
