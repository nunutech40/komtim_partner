import 'package:flutter/material.dart';
import 'package:komtim_partner/common/enum_status.dart';
import 'package:komtim_partner/common/styles.dart';
import 'package:komtim_partner/presentation/pages/home/bloc/main_bloc.dart';
import 'package:komtim_partner/presentation/pages/home/view/profile_page.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../router/app_router.dart';
import '../../../router/router_utils.dart';
import 'history_page.dart';
import 'home_page.dart';

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

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainBloc, MainState>(
      listener: (context, state) => _handleStateChange(context, state),
      child: _buildScaffold(),
    );
  }

  void _handleStateChange(BuildContext context, MainState state) {
    var isSnackBarActive = false;

    if (state.status == RequestStatus.success) {
      AppRouter.router.go(PAGES.main.screenPath);
    } else {
      AppRouter.router.go(PAGES.login.screenPath);
    }
    if (state.status == RequestStatus.failure && !isSnackBarActive) {
      isSnackBarActive = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              isSnackBarActive = false;
            },
          ),
        ),
      );
    }
  }

  Widget _buildScaffold() {
    final List<BottomNavigationBarItem> _bottomNavBarItems = [
      BottomNavigationBarItem(
        icon: _bottomNavIndex == 0
            ? Image.asset('assets/images/ic_home_active.png',
                width: 28, height: 28)
            : Image.asset('assets/images/ic_home-inactive.png'),
        label: _headlineText,
      ),
      BottomNavigationBarItem(
        icon: _bottomNavIndex == 1
            ? Image.asset('assets/images/ic_archive-book-active.png')
            : Image.asset('assets/images/ic_archive-book_inactive.png'),
        label: 'History',
      ),
      BottomNavigationBarItem(
        icon: _bottomNavIndex == 2
            ? Image.asset('assets/images/ic_profile-circle-active.png')
            : Image.asset('assets/images/ic_profile-circle-inactive.png'),
        label: 'Profile',
      ),
    ];

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
