import 'package:flutter/material.dart';
import 'package:subscribe_manager/Pages/HomePage.dart';
import 'package:subscribe_manager/Pages/MySubscriptionsPage.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    MySubscriptionsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 0) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => _pages.elementAt(_selectedIndex)));
      }
      if (_selectedIndex == 1) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => _pages.elementAt(_selectedIndex)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            color: Colors.black,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.list_outlined,
            color: Colors.black,
          ),
          label: 'My Subscriptions',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      // const Color(0xFFF6925C),
      onTap: _onItemTapped,
      backgroundColor: Colors.white,
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
    );
  }
}
