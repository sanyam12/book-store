import 'package:book_store/pages/StorePage.dart';
import 'package:flutter/material.dart';

import '../pages/LibraryPage.dart';

//This Widget Implement the Bottom Navigation and also inserts the selected Widget
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});


  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  //Index of the selected Widget.
  int _selectedIndex = 0;

  //List of Screens in the Bottom Navigation
  late final List<Widget> _pages = [
    const LibraryPage(),
    const StorePage(),
  ];

  //Invoked when any item in Bottom Navigation is tapped
  //Updates the _selectedIndex to the new selected index.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meta Book Store"),
      ),
      //Displays only the selected Screen from the list of all the Screens
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      //Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: "Library"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: "Store"
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
