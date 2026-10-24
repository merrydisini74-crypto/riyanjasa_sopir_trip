import 'package:flutter/material.dart';
import '../models/driver.dart';

class FavoriteScreen extends StatefulWidget {
  final List<Driver> favoriteDrivers;
  final Function(Driver) onRemoveFavorite;

  const FavoriteScreen({
    super.key,
    required this.favoriteDrivers,
    required this.onRemoveFavorite,
  });

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filter pencarian real-time untuk sopir favorit
    final filteredDrivers = widget.favoriteDrivers.where((driver) {
      return driver.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          driver.vehicleTypes.any((v) => v.toLowerCase().contains(_searchQuery.toLowerCase()));
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Favorit Saya',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${widget.favoriteDrivers.length} Sopir Tersimpan',
            style: const TextStyle(color: Colors.white54, fontSize: 13),
          ),
          const SizedBox(height: 16),

          // Search Bar
          TextField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Cari sopir atau kendaraan favorit...',
              hintStyle: const TextStyle(color: Colors.white54),
              prefixIcon: const Icon(Icons.search, color: Colors.white54),
              filled: true,
              fillColor: const Color(0xFF1E293B),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: filteredDrivers.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.white24,
                          size: 64,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Tidak ada sopir favorit ditemukan',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredDrivers.length,
                    itemBuilder: (context, index) {
                      final driver = filteredDrivers[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                driver.imageUrl,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.grey[800],
                                  child: const Icon(
                                    Icons.person,
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    driver.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    driver.vehicleTypes.join(', '),
                                    style: const TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Rp ${driver.pricePerDay}',
                                    style: const TextStyle(
                                      color: Color(0xFF3B82F6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.favorite_rounded,
                                color: Color(0xFFEF4444),
                              ),
                              onPressed: () {
                                widget.onRemoveFavorite(driver);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${driver.name} dihapus dari favorit'),
                                    duration: const Duration(seconds: 2),
                                    backgroundColor: Colors.redAccent,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}