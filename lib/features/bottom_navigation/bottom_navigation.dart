import 'package:flutter/material.dart';
import 'package:hubaix/features/bottom_navigation/pages/home_page/presentation/home_page.dart';
import 'package:hubaix/features/bottom_navigation/pages/member_page/presentation/member_page.dart';
import 'package:hubaix/features/bottom_navigation/pages/population_stats/presentation/population_data_page.dart';
import 'package:hubaix/features/chatbot/presentation/chatbot_screen.dart';
import 'package:hubaix/features/bottom_navigation/pages/service_location/presentation/service_location_page.dart';
import 'package:hubaix/utils/utils.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const MemberPage(),
    const PopulationDataPage(),
    // RequestPage(),
    const ServiceLocationPage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Utils.showBottomSheet(context, ChatBot());
        },
        tooltip: 'Open Chat',
        child: const Icon(
          Icons.smart_toy_rounded,
          size: 25,
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          navigationBarTheme: NavigationBarThemeData(
            indicatorColor: Colors.blue.withOpacity(0.1),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.business_center_outlined),
              selectedIcon: Icon(Icons.business_center),
              label: 'Members',
            ),
            NavigationDestination(
              icon: Icon(Icons.people_outline),
              selectedIcon: Icon(Icons.people),
              label: 'Stats',
            ),
            NavigationDestination(
              icon: Icon(Icons.location_on_outlined),
              selectedIcon: Icon(Icons.location_on),
              label: 'Lyari',
            ),
          ],
        ),
      ),
    );
  }
}
