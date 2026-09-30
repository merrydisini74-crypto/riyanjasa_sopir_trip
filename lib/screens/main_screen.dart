import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/driver.dart';
import 'home_screen.dart';
import 'favorite_screen.dart';
import 'about_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Mengambil list driver awal dari mock_data
  final List<Driver> _drivers = List.from(dummyDrivers);

  void _toggleFavorite(Driver driver) {
    setState(() {
      driver.isFavorite = !driver.isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          driver.isFavorite
              ? '${driver.name} ditambahkan ke Favorit'
              : '${driver.name} dihapus dari Favorit',
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favoriteDrivers = _drivers.where((d) => d.isFavorite).toList();

    // List Halaman Aplikasi
    final List<Widget> pages = [
      HomeScreen(
        drivers: _drivers,
        onToggleFavorite: _toggleFavorite,
      ),
      FavoriteScreen(
        favoriteDrivers: favoriteDrivers,
        onRemoveFavorite: _toggleFavorite,
      ),
      const AboutScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: const Color(0xFF1E293B),
          selectedItemColor: const Color(0xFF3B82F6),
          unselectedItemColor: const Color(0xFF64748B),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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
              icon: Icon(Icons.info_outline_rounded),
              label: 'Tentang',
            ),
          ],
        ),
      ),
    );
  }
}