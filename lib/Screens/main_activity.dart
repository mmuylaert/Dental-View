import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/bottom_new_provider.dart';
import 'BottomNavPages/Account/accounts.dart';
import 'BottomNavPages/Diagnostics/diagnostics.dart';
import 'BottomNavPages/Home/home.dart';

class MainActivityPage extends StatefulWidget {
  const MainActivityPage({super.key});

  @override
  State<MainActivityPage> createState() => _MainActivityPageState();
}

class _MainActivityPageState extends State<MainActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavProvider>(
      builder: (context, nav, child)
    {
      return Scaffold(
        body: _pages[nav.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: _items,
          currentIndex: nav.currentIndex,
          onTap: (value) {
            nav.changeIndex = value;
          },
        ),
      );
    }
    );
  }

  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const DiagnosticsPage(),
    const AccountsPage(),

  ];

  final List<BottomNavigationBarItem> _items = const <BottomNavigationBarItem>[
  BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
  BottomNavigationBarItem(icon: Icon(Icons.poll), label: 'Diagnósticos'),
  BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
   ];
  }