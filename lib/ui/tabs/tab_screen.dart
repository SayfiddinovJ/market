import 'package:flutter/material.dart';
import 'package:market/ui/tabs/category/category_screen.dart';
import 'package:market/ui/tabs/home/home_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> screens = [];

  int currentIndex = 0;

  @override
  void initState() {
    screens = [HomeScreen(), CategoryScreen()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Mahsulotlar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Kategoriyalar",
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
