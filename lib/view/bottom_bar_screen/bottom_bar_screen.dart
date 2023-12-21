import 'package:flutter/material.dart';
import 'package:notely_app/utils/color_constant.dart';
import 'package:notely_app/utils/textstyle_constant.dart';
import 'package:notely_app/view/home_screen/home_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
//BottomNavigationBar

  static List<Widget> widgetOptions = <Widget>[
    HomeScreen(),
    Text(
      'Index 1: Business',
    ),
  ];

  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgcolor,
        centerTitle: true,
        title: Text(
          'NOTELY',
          style: maintextdark,
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: primarycolordark,
              ))
        ],
      ),
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bgcolor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: primarycolordark,
        selectedLabelStyle: subtextdark,
        selectedIconTheme: IconThemeData(size: 30),
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: subtextdark,
        unselectedIconTheme: IconThemeData(size: 30),
        onTap: onItemTapped,
      ),
    );
  }
}
