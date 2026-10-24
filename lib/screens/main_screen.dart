import 'package:flutter/material.dart';
import '../models/driver.dart';
import 'home_screen.dart';
import 'favorite_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List<Driver> favoriteDrivers = [];

  // Fungsi Toggle Tambah / Hapus Favorit
  void _toggleFavorite(Driver driver) {
    setState(() {
      if (favoriteDrivers.contains(driver)) {
        favoriteDrivers.remove(driver);
      } else {
        favoriteDrivers.add(driver);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(
        favoriteDrivers: favoriteDrivers,
        onToggleFavorite: _toggleFavorite, drivers: [],
      ),
      FavoriteScreen(
        favoriteDrivers: favoriteDrivers,
        onRemoveFavorite: _toggleFavorite,
      ),
      ProfileScreen(
        onLogout: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(child: screens[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF1E293B),
        selectedItemColor: const Color(0xFF3B82F6),
        unselectedItemColor: Colors.white54,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: 'Favorit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Tentang',
          ),
        ],
      ),
    );
  }
}