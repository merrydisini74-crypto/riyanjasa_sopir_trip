class Driver {
  final String id;
  final String name; // Nama Sopir atau Nama Mobil
  final String location;
  final double rating;
  final int reviewsCount;
  final int experience; // Pengalaman (tahun) / Kapasitas (kursi)
  final double pricePerDay;
  final List<String> vehicleTypes; // Keahlian / Tipe Transmisi
  final String imageUrl;
  final bool isAvailable;
  bool isFavorite;
  final String category; // Kategori (Sopir VIP, Mobil SUV, Sewa Paket, dll)
  final String description;
  final String itemType; // 'sopir' atau 'mobil'

  Driver({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.reviewsCount,
    required this.experience,
    required this.pricePerDay,
    required this.vehicleTypes,
    required this.imageUrl,
    this.isAvailable = true,
    this.isFavorite = false,
    required this.category,
    required this.description,
    this.itemType = 'sopir',
  });

  String get city => location;
  int get experienceYears => experience;
}