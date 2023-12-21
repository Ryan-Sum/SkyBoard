import 'package:flutter/material.dart';
import 'package:sky_board/account_page/account_page.dart';
import 'package:sky_board/calendar_page/calendar_page.dart';
import 'package:sky_board/community_page/community_page.dart';
import 'package:sky_board/dashboard_page/dashboard_page.dart';
import 'package:sky_board/map_page/map_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  List<Widget> pages = [
    const DashboardPage(),
    const CalendarPage(),
    const CommunityPage(),
    const MapPage(),
    const AccountPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        currentIndex: _index,
        unselectedItemColor: Theme.of(context).colorScheme.onBackground,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_customize_rounded),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: "Calendar",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_rounded),
            label: "Community",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_rounded),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
