import 'package:flutter/material.dart';
import 'package:komtim_partner/common/styles.dart';
import 'package:komtim_partner/presentation/pages/home/history_page.dart';
import 'package:komtim_partner/presentation/pages/home/home_page.dart';
import 'package:komtim_partner/presentation/pages/home/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _bottomNavIndex = 0;
  static const String _headlineText = 'Beranda';

  final List<Widget> _listWidget = [
    const HomePage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.restaurant),
      label: _headlineText,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.bookmark),
      label: 'History',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Profile',
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}
