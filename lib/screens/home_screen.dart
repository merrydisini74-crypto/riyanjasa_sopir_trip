import 'package:flutter/material.dart';
import '../models/driver.dart';
import '../widgets/driver_card.dart';

class HomeScreen extends StatefulWidget {
  final List<Driver> drivers;
  final Function(Driver) onToggleFavorite;

  const HomeScreen({
    super.key,
    required this.drivers,
    required this.onToggleFavorite,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'Semua';
  String _searchQuery = '';

  List<String> categories = ['Semua', 'Luar Kota', 'Mewah / VIP', 'Harian', 'Pariwisata', 'Sewa Mobil'];

  List<Driver> get _filteredDrivers {
    return widget.drivers.where((driver) {
      bool matchesCategory = true;
      if (_selectedCategory == 'Sewa Mobil') {
        matchesCategory = driver.itemType == 'mobil';
      } else if (_selectedCategory != 'Semua') {
        matchesCategory = driver.category.contains(_selectedCategory);
      }
      if (_selectedCategory == 'Luar Kota') {
        matchesCategory = driver.category.contains('Luar Kota');
       
      } else if (_selectedCategory == 'Mewah / VIP') {
        matchesCategory = driver.category.contains('VIP') || driver.category.contains('Mewah');
      } else if (_selectedCategory == 'Harian') {
        matchesCategory = driver.category.contains('Harian');
      } else if (_selectedCategory == 'Pariwisata') {
        matchesCategory = driver.category.contains('Pariwisata');
      }

      bool matchesSearch = driver.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          driver.city.toLowerCase().contains(_searchQuery.toLowerCase());

      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _showDriverDetail(BuildContext context, Driver driver) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: const Color(0xFF1E293B),
          child: Container(
            width: 420,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Foto Detail Sopir
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: driver.imageUrl.startsWith('http')
                          ? Image.network(driver.imageUrl, fit: BoxFit.cover)
                          : Image.asset(driver.imageUrl, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        driver.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2563EB),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          driver.category,
                          style: const TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded, color: Colors.white54, size: 16),
                      const SizedBox(width: 4),
                      Text(driver.city, style: const TextStyle(color: Colors.white70)),
                      const SizedBox(width: 16),
                      const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${driver.rating} (${driver.experienceYears} thn exp)',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white10, height: 24),
                  const Text(
                    'Deskripsi & Keahlian',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    driver.description.isNotEmpty
                        ? driver.description
                        : 'Sopir berpengalaman, ramah, dan mengutamakan keselamatan dalam perjalanan.',
                    style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Tarif Per Hari', style: TextStyle(color: Colors.white54, fontSize: 12)),
                          Text(
                            'Rp ${driver.pricePerDay}',
                            style: const TextStyle(
                              color: Color(0xFF3B82F6),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Pemesanan untuk ${driver.name} telah diproses!')),
                          );
                        },
                        icon: const Icon(Icons.directions_car_rounded),
                        label: const Text('Pesan Sopir'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Menghitung jumlah kolom grid otomatis berdasarkan lebar layar PC / Browser
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 1200
        ? 5
        : screenWidth > 800
            ? 4
            : screenWidth > 600
                ? 3
                : 2;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Halo, User RiyanJasa!', style: TextStyle(color: Colors.white54, fontSize: 13)),
                        SizedBox(height: 2),
                        Text(
                          'Pilih Sopir Anda',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Search Input
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: TextField(
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val;
                      });
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.search_rounded, color: Colors.white54),
                      hintText: 'Cari nama sopir atau kota...',
                      hintStyle: TextStyle(color: Colors.white38),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Filter Categories
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories.map((cat) {
                      return _buildFilterChip(cat, _selectedCategory == cat);
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Sopir Rekomendasi (${_filteredDrivers.length})',
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          sliver: _filteredDrivers.isEmpty
              ? const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Text('Sopir tidak ditemukan', style: TextStyle(color: Colors.white54)),
                    ),
                  ),
                )
              : SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 0.75, // Rasio ukuran kartu
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final driver = _filteredDrivers[index];
                      return DriverCard(
                        driver: driver,
                        onFavoriteToggle: () => widget.onToggleFavorite(driver),
                        onTap: () => _showDriverDetail(context, driver),
                      );
                    },
                    childCount: _filteredDrivers.length,
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.transparent : Colors.white10),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white60,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}