import 'package:flutter/material.dart';
import 'package:sky_board/account_page/account_page.dart';
import 'package:sky_board/calendar_page/calendar_page.dart';
import 'package:sky_board/dashboard_page/dashboard_page.dart';
import 'package:sky_board/print_page/print_page.dart';
import 'package:sky_board/social_media/social_media.dart';

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
    const PrintPage(),
    const SocialMedia(),
    const AccountPage(),
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
            icon: Icon(Icons.print_rounded),
            label: "Print",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share_rounded),
            label: "Social Media",
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
