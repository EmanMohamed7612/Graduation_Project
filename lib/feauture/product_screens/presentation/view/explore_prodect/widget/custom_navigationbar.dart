

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../home/presentation/view/home_screen.dart';
import '../../../../comming_soon_screen.dart';
import '../explore_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0; // ابدأي من الصفر عشان يفتح الهوم أول ما يشتغل

  // قائمة الصفحات
  final List<Widget> _pages = [
    const HomeScreen(),
    const ExploreAllScreen(),
    const ComingSoonScreen(title: 'Community'),
    const ComingSoonScreen(title: 'AI'),
    const ComingSoonScreen(title: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // عرض الصفحة بناءً على الاندكس المختار
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_awesome), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}