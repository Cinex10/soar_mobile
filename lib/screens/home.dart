import 'package:flutter/material.dart';
import 'package:soar_mobile/screens/devices.dart';
import 'package:soar_mobile/screens/incident.dart';
import 'package:soar_mobile/screens/statistics.dart';
import 'package:soar_mobile/screens/warnings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  List<Widget> _screens = [
    WarningsScreen(),
    IncidentScreen(),
    DevicesScreen(),
    StatisticsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Dashboard'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.shifting,
        useLegacyColorScheme: true,
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() {
            _currentIndex = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.find_in_page),
            backgroundColor: Colors.white,
            label: 'Warnings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            backgroundColor: Colors.white,
            label: 'Incidents',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.devices),
            label: 'Devices',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.auto_graph),
            label: 'Statics',
          ),
        ],
      ),
    );
  }
}
