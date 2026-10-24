import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback onLogout;

  const ProfileScreen({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          const Text(
            'Profil Saya',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          
          // Avatar Profil Interaktif
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur ganti foto profil akan segera hadir!')),
              );
            },
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF3B82F6), width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 45,
                    backgroundColor: Color(0xFF1E293B),
                    child: Icon(Icons.person, size: 50, color: Colors.white54),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFF3B82F6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.camera_alt, size: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          const Text(
            'Alex Pratama',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'alex.pratama@gmail.com',
            style: TextStyle(color: Colors.white54, fontSize: 13),
          ),
          const SizedBox(height: 24),

          // Statistik Kartu
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _StatItem(title: 'Pemesanan', value: '12'),
                _VerticalDivider(),
                _StatItem(title: 'Favorit', value: '4'),
                _VerticalDivider(),
                _StatItem(title: 'Status', value: 'VIP'),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Pengaturan Akun Section
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Pengaturan Akun',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),

          _ProfileMenuItem(
            icon: Icons.person_outline,
            title: 'Edit Profil',
            onTap: () {
              _showInfoDialog(context, 'Edit Profil', 'Fitur edit profil akun pengguna RiyanJasaTrip.');
            },
          ),
          _ProfileMenuItem(
            icon: Icons.history,
            title: 'Riwayat Pemesanan',
            onTap: () {
              _showInfoDialog(context, 'Riwayat Pemesanan', 'Anda memiliki 12 riwayat perjalanan sukses.');
            },
          ),
          _ProfileMenuItem(
            icon: Icons.payment_outlined,
            title: 'Metode Pembayaran',
            onTap: () {
              _showInfoDialog(context, 'Metode Pembayaran', 'Kartu Debit & E-Wallet terhubung (Aktif).');
            },
          ),
          _ProfileMenuItem(
            icon: Icons.info_outline,
            title: 'About RiyanJasaTrip',
            onTap: () {
              _showInfoDialog(context, 'Tentang Aplikasi', 'RiyanJasaTrip v1.0.0\nProyek UTS Platform-Based Programming.');
            },
          ),
          const SizedBox(height: 24),

          // Tombol Logout dengan Konfirmasi Dialog
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: const Color(0xFF1E293B),
                    title: const Text('Keluar Akun', style: TextStyle(color: Colors.white)),
                    content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?', style: TextStyle(color: Colors.white70)),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Batal', style: TextStyle(color: Colors.white54)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          onLogout();
                        },
                        child: const Text('Keluar', style: TextStyle(color: Color(0xFFEF4444))),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Keluar dari Akun (Log Out)', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        content: Text(content, style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup', style: TextStyle(color: Color(0xFF3B82F6))),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final String value;

  const _StatItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 1,
      color: Colors.white10,
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF3B82F6)),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white54),
        onTap: onTap,
      ),
    );
  }
}