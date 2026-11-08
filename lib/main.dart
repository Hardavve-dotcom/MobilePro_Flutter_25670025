import 'package:flutter/material.dart';

// ============================================================================
// KONFIGURASI WARNA & TEMA (MUDAH DIUBAH SENDIRI)
// ============================================================================
class AppTheme {
  static const Color primaryColor = Color(0xFFC62828);     // Merah Khas Lumpia
  static const Color secondaryColor = Color(0xFFFFA000);   // Kuning Aksen
  static const Color backgroundColor = Color(0xFFF5F5F5);  // Background Abu Muda
  static const Color cardBackground = Colors.white;        // Warna Kartu
  static const Color textDark = Color(0xFF212121);         // Teks Utama
  static const Color textMuted = Color(0xFF757575);        // Teks Deskripsi
}

void main() {
  runApp(const LumpiaSemarangApp());
}

class LumpiaSemarangApp extends StatelessWidget {
  const LumpiaSemarangApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuliner Lumpia Semarang',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: AppTheme.backgroundColor,
      ),
      home: const HomePage(),
    );
  }
}

// ============================================================================
// HALAMAN 1: HOME PAGE (BERANDA UTAMA)
// ============================================================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuliner Lumpia Semarang'),
        backgroundColor: AppTheme.primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Spacing: Padding modul materi
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Kartu Profil / Header Tema
              Container(
                margin: const EdgeInsets.only(bottom: 16.0), // Spacing: Margin
                padding: const EdgeInsets.all(20.0),        // Spacing: Padding
                decoration: BoxDecoration(
                  color: AppTheme.cardBackground,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Gambar Utama menggunakan Image.asset sesuai materi
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        'assets/images/lumpia_goreng.jpg',
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover, // Properti Image sesuai materi
                      ),
                    ),
                    const SizedBox(height: 16), // Spacing: SizedBox
                    const Text(
                      'Lumpia Legendaris Khas Semarang',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Nikmati kelezatan Lumpia Goreng dan Lumpia Basah otentik langsung dari Kota Semarang.',
                      style: TextStyle(fontSize: 14, color: AppTheme.textMuted),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Tombol Navigasi ke Halaman Katalog Menu (Menggunakan Navigator.push)
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.restaurant_menu, color: Colors.white),
                label: const Text(
                  'Buka Katalog Menu',
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  // Praktik Navigator.push() sesuai modul materi
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MenuListPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              // Tombol Navigasi ke Halaman Tentang Pengembang
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.primaryColor, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.info_outline, color: AppTheme.primaryColor),
                label: const Text(
                  'Tentang Pembuat Aplikasi',
                  style: TextStyle(fontSize: 16, color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutPage(
                        nama: 'Hardafa Islami Al Irsyad',
                        nim: '25670025',
                        prodi: 'Informatika',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// HALAMAN 2: MENU LIST PAGE (KATALOG PILIHAN MENU)
// ============================================================================
class MenuListPage extends StatelessWidget {
  const MenuListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Menu Lumpia'),
        backgroundColor: AppTheme.primaryColor,
        // Tombol kembali otomatis atau menggunakan Navigator.pop
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Item 1: Lumpia Goreng
          _buildMenuCard(
            context: context,
            namaMenu: 'Lumpia Goreng Semarang',
            kategori: 'Kuliner Rebung & Udang',
            harga: 'Rp 18.000',
            imagePath: 'assets/images/lumpia_goreng.jpg',
            deskripsi: 'Kulit lumpia renyah dengan isian rebung manis, udang segar, dan telur orak-arik. Disajikan dengan saus tauco dan cabai rawit.',
          ),
          const SizedBox(height: 16),
          // Item 2: Lumpia Basah
          _buildMenuCard(
            context: context,
            namaMenu: 'Lumpia Basah Khas',
            kategori: 'Kuliner Tradisional',
            harga: 'Rp 16.000',
            imagePath: 'assets/images/lumpia_basah.jpg',
            deskripsi: 'Lumpia lembut tanpa digoreng, berisi rebung segar pilihan dengan siraman kuah saus gula aren khas Semarang yang lezat.',
          ),
        ],
      ),
    );
  }

  // Widget pembantu untuk kartu menu menggunakan Layout (Row & Column)
  Widget _buildMenuCard({
    required BuildContext context,
    required String namaMenu,
    required String kategori,
    required String harga,
    required String imagePath,
    required String deskripsi,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () {
          // Navigasi ke Halaman Detail dengan mengirim data parameter (Sesuai materi praktikum)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailMenuPage(
                namaMenu: namaMenu,
                kategori: kategori,
                harga: harga,
                imagePath: imagePath,
                deskripsi: deskripsi,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  imagePath,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      namaMenu,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      kategori,
                      style: const TextStyle(fontSize: 12, color: AppTheme.textMuted),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          harga,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.textMuted),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// HALAMAN 3: DETAIL MENU PAGE (MENERIMA DATA & NAVIGASI POP)
// ============================================================================
class DetailMenuPage extends StatelessWidget {
  final String namaMenu;
  final String kategori;
  final String harga;
  final String imagePath;
  final String deskripsi;

  const DetailMenuPage({
    super.key,
    required this.namaMenu,
    required this.kategori,
    required this.harga,
    required this.imagePath,
    required this.deskripsi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(namaMenu),
        backgroundColor: AppTheme.primaryColor,
        // Praktik Navigator.pop() sesuai modul materi
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          namaMenu,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
                          ),
                        ),
                      ),
                      Text(
                        harga,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    kategori,
                    style: const TextStyle(fontSize: 14, color: AppTheme.textMuted),
                  ),
                  const Divider(height: 30, thickness: 1),
                  const Text(
                    'Deskripsi Menu:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    deskripsi,
                    style: const TextStyle(fontSize: 14, height: 1.5, color: AppTheme.textDark),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.shopping_cart, color: Colors.white),
                      label: const Text(
                        'Pesan Menu Ini',
                        style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Berhasil memesan $namaMenu!')),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// HALAMAN 4: ABOUT PAGE (PROFIL PENGEMBANG APLIKASI)
// ============================================================================
class AboutPage extends StatelessWidget {
  final String nama;
  final String nim;
  final String prodi;

  const AboutPage({
    super.key,
    required this.nama,
    required this.nim,
    required this.prodi,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengembang'),
        backgroundColor: AppTheme.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundColor: AppTheme.primaryColor,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  nama,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'NIM: $nim',
                  style: const TextStyle(fontSize: 15, color: AppTheme.textMuted),
                ),
                const SizedBox(height: 4),
                Text(
                  'Program Studi: $prodi',
                  style: const TextStyle(fontSize: 15, color: AppTheme.textMuted),
                ),
                const Divider(height: 30),
                const Text(
                  'Aplikasi Praktikum Mobile Programming - UPGRIS',
                  style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: AppTheme.textMuted),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}