import 'package:flutter/material.dart';

import 'category/category_screen.dart';
import 'home/home_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Widget> screens = [];
  int index = 0;

  @override
  void initState() {
    screens = [HomeScreen(), CategoryScreen()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() => this.index = index),
        currentIndex: index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Barchasi'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Kategoriyalar',
          ),
        ],
      ),
    );
  }
}
