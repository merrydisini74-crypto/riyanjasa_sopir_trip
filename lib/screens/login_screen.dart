import 'package:flutter/material.dart';
import 'main_screen.dart'; // Import MainScreen agar navigasi lancar

// Model Sederhana Pengguna
class UserModel {
  final String name;
  final String email;
  final String password;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
  });
}

// Database sementara (In-Memory) untuk menyimpan akun yang terdaftar
class UserSession {
  static UserModel? currentUser;
  
  // Akun default awal
  static final List<UserModel> registeredUsers = [
    UserModel(
      name: 'Riyan Purnama',
      email: 'riyan.purnama@email.com',
      password: '123',
    ),
  ];
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoginMode = true; // Status mode Login atau Register

  // Controller Login
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController = TextEditingController();

  // Controller Register
  final TextEditingController _regNameController = TextEditingController();
  final TextEditingController _regEmailController = TextEditingController();
  final TextEditingController _regPasswordController = TextEditingController();

  @override
  void dispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _regNameController.dispose();
    _regEmailController.dispose();
    _regPasswordController.dispose();
    super.dispose();
  }

  // --- FUNGSI LOGIN ---
  void _handleLogin() {
    final email = _loginEmailController.text.trim();
    final password = _loginPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar('Email dan Kata Sandi wajib diisi!', Colors.orangeAccent);
      return;
    }

    // Cek apakah akun terdaftar
    final userMatch = UserSession.registeredUsers.firstWhere(
      (user) => user.email.toLowerCase() == email.toLowerCase() && user.password == password,
      orElse: () => UserModel(name: '', email: '', password: ''),
    );

    if (userMatch.email.isNotEmpty) {
      // Simpan user aktif
      UserSession.currentUser = userMatch;
      
      _showSnackBar('Login berhasil! Selamat datang, ${userMatch.name}', Colors.green);

      // Pindah ke MainScreen (Mengatasi Error Parameter 'drivers')
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      _showSnackBar('Akun belum terdaftar atau password salah!', Colors.redAccent);
    }
  }

  // --- FUNGSI REGISTRASI (DAFTAR AKUN BARU) ---
  void _handleRegister() {
    final name = _regNameController.text.trim();
    final email = _regEmailController.text.trim();
    final password = _regPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showSnackBar('Semua field registrasi wajib diisi!', Colors.orangeAccent);
      return;
    }

    // Cek apakah email sudah terdaftar sebelumnya
    final isExist = UserSession.registeredUsers.any(
      (user) => user.email.toLowerCase() == email.toLowerCase(),
    );

    if (isExist) {
      _showSnackBar('Email ini sudah terdaftar! Silakan login.', Colors.amberAccent);
      return;
    }

    // Tambahkan user baru ke daftar terdaftar
    final newUser = UserModel(name: name, email: email, password: password);
    UserSession.registeredUsers.add(newUser);

    _showSnackBar('Pendaftaran berhasil! Silakan login dengan akun baru.', Colors.green);

    // Reset controller & ganti ke tampilan Login
    _regNameController.clear();
    _regEmailController.clear();
    _regPasswordController.clear();
    
    // Auto fill email login
    _loginEmailController.text = email;

    setState(() {
      isLoginMode = true;
    });
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient Overlay Dark
          Container(
            color: Colors.black.withOpacity(0.65),
          ),
          
          // Header Logo & Title
          Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Column(
              children: const [
                Text(
                  'DrivePro',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Layanan Jasa Sopir & Sewa Mobil Profesional',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // Form Box (Login / Register)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B).withOpacity(0.95),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      isLoginMode ? 'Masuk ke Akun' : 'Daftar Akun Baru',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    if (!isLoginMode) ...[
                      // Field Nama Lengkap (Registrasi)
                      TextField(
                        controller: _regNameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration('Nama Lengkap', Icons.person_outline),
                      ),
                      const SizedBox(height: 12),
                      // Field Email Registrasi
                      TextField(
                        controller: _regEmailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration('Email', Icons.email_outlined),
                      ),
                      const SizedBox(height: 12),
                      // Field Password Registrasi
                      TextField(
                        controller: _regPasswordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration('Kata Sandi', Icons.lock_outline),
                      ),
                    ] else ...[
                      // Field Email Login
                      TextField(
                        controller: _loginEmailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration('Email', Icons.email_outlined),
                      ),
                      const SizedBox(height: 12),
                      // Field Password Login
                      TextField(
                        controller: _loginPasswordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: _inputDecoration('Kata Sandi', Icons.lock_outline),
                      ),
                    ],

                    const SizedBox(height: 20),

                    // Tombol Submit
                    ElevatedButton(
                      onPressed: isLoginMode ? _handleLogin : _handleRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        isLoginMode ? 'MASUK SEKARANG' : 'DAFTAR SEKARANG',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Switch Login / Register Mode
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isLoginMode ? 'Belum punya akun? ' : 'Sudah punya akun? ',
                          style: const TextStyle(color: Colors.white60, fontSize: 12),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isLoginMode = !isLoginMode;
                            });
                          },
                          child: Text(
                            isLoginMode ? 'Daftar di sini' : 'Masuk di sini',
                            style: const TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      hintText: label,
      hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
      prefixIcon: Icon(icon, color: Colors.white38, size: 20),
      filled: true,
      fillColor: const Color(0xFF0F172A),
      contentPadding: const EdgeInsets.symmetric(vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }
}