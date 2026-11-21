import 'package:flutter/material.dart';

void main() {
  runApp(const FormulirPraktikumApp());
}

class FormulirPraktikumApp extends StatelessWidget {
  const FormulirPraktikumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulir Registrasi Mahasiswa Fakultas Teknik dan Informatika',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 60, 82, 207)),
        useMaterial3: true,
      ),
      home: const FormRegistrasiPage(),
    );
  }
}

class FormRegistrasiPage extends StatefulWidget {
  const FormRegistrasiPage({super.key});

  @override
  State<FormRegistrasiPage> createState() => _FormRegistrasiPageState();
}

class _FormRegistrasiPageState extends State<FormRegistrasiPage> {
  // Key untuk mengakses dan memvalidasi seluruh isi Form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controller untuk membaca dan mengelola nilai input teks
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _npmController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _kelasController = TextEditingController();
  final TextEditingController _hobiLainnyaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();

  // State untuk toggle password & persetujuan
  bool _obscurePassword = true;
  bool _setujuSyarat = false;

  // State Radio (pilihan tunggal dalam satu kelompok)
  String? _jenisKelamin = 'Laki-laki';

  // State Checkbox (pilihan independen, boleh lebih dari satu)
  bool _hobiMembaca = false;
  bool _hobiMusik = false;
  bool _hobiOlahraga = false;
  bool _hobiFotografi = false;
  bool _hobiLainnya = false;

  // State Dropdown Program Studi Fakultas Teknik dan Informatika
  final List<String> _daftarProdi = [
    'Teknik Mesin',
    'Teknik Elektro',
    'Teknik Sipil',
    'Informatika',
    'Teknologi Pangan',
    'Arsitektur',
  ];
  String? _prodiTerpilih;

  @override
  void dispose() {
    _namaController.dispose();
    _npmController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _kelasController.dispose();
    _hobiLainnyaController.dispose();
    _alamatController.dispose();
    _tanggalController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _tanggalController.text =
            '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
  }

  List<String> _getHobiTerpilih() {
    final List<String> terpilih = [];
    if (_hobiMembaca) terpilih.add('Membaca');
    if (_hobiMusik) terpilih.add('Musik');
    if (_hobiOlahraga) terpilih.add('Olahraga');
    if (_hobiFotografi) terpilih.add('Fotografi');
    if (_hobiLainnya) {
      final String detailLainnya = _hobiLainnyaController.text.trim();
      if (detailLainnya.isNotEmpty) {
        terpilih.add('Lainnya ($detailLainnya)');
      } else {
        terpilih.add('Lainnya');
      }
    }
    return terpilih;
  }

  void _simpanForm() {
    final bool isFormValid = _formKey.currentState!.validate();

    if (!isFormValid) {
      return;
    }

    if (!_setujuSyarat) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Centang persetujuan syarat dan ketentuan terlebih dahulu.'),
        ),
      );
      return;
    }

    final List<String> hobi = _getHobiTerpilih();
    final String ringkasanHobi =
        hobi.isEmpty ? 'Tidak ada hobi dipilih' : hobi.join(', ');

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ringkasan Data Pendaftaran'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Nama Lengkap: ${_namaController.text.trim()}'),
                const SizedBox(height: 6),
                Text('NPM: ${_npmController.text.trim()}'),
                const SizedBox(height: 6),
                Text('Email: ${_emailController.text.trim()}'),
                const SizedBox(height: 6),
                Text('Program Studi: ${_prodiTerpilih ?? '-'}'),
                const SizedBox(height: 6),
                Text('Kelas: ${_kelasController.text.trim()}'),
                const SizedBox(height: 6),
                Text('Jenis Kelamin: ${_jenisKelamin ?? '-'}'),
                const SizedBox(height: 6),
                Text('Hobi: $ringkasanHobi'),
                const SizedBox(height: 6),
                Text(
                  'Tanggal Daftar: ${_tanggalController.text.isEmpty ? '-' : _tanggalController.text}',
                ),
                const SizedBox(height: 6),
                Text(
                  'Alamat / Catatan: ${_alamatController.text.trim().isEmpty ? '-' : _alamatController.text.trim()}',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Formulir Registrasi Mahasiswa Fakultas Teknik dan Informatika',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Data Pengguna',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // 1. Nama Lengkap (wajib diisi)
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Lengkap',
                  hintText: 'Masukkan nama lengkap',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama lengkap wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // 2. NPM (angka, minimal 8 digit)
              TextFormField(
                controller: _npmController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'NPM',
                  hintText: 'Minimal 8 digit angka',
                  prefixIcon: const Icon(Icons.badge),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (String? value) {
                  final String trimmed = value?.trim() ?? '';
                  if (trimmed.isEmpty) {
                    return 'NPM wajib diisi';
                  }
                  if (!RegExp(r'^\d+$').hasMatch(trimmed)) {
                    return 'NPM harus berupa angka';
                  }
                  if (trimmed.length < 8) {
                    return 'NPM minimal 8 digit';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // 3. Email (format valid)
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'nama@email.com',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (String? value) {
                  final String trimmed = value?.trim() ?? '';
                  if (trimmed.isEmpty) {
                    return 'Email wajib diisi';
                  }
                  final bool validEmail = RegExp(
                    r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(trimmed);
                  if (!validEmail) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // 4. Password (minimal 8 karakter + obscureText)
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Minimal 8 karakter',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Password wajib diisi';
                  }
                  if (value.length < 8) {
                    return 'Password minimal 8 karakter';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // 5. Tanggal Pendaftaran (Date Picker)
              TextFormField(
                controller: _tanggalController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Tanggal Pendaftaran',
                  hintText: 'Pilih tanggal',
                  suffixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onTap: _pickDate,
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Tanggal pendaftaran wajib dipilih';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // 6. Program Studi (Dropdown)
              DropdownButtonFormField<String>(
                value: _prodiTerpilih,
                decoration: InputDecoration(
                  labelText: 'Program Studi',
                  prefixIcon: const Icon(Icons.school),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                hint: const Text('Pilih program studi'),
                items: _daftarProdi.map((String prodi) {
                  return DropdownMenuItem<String>(
                    value: prodi,
                    child: Text(prodi),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _prodiTerpilih = newValue;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Program studi wajib dipilih';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              // 7. Kelas (isi sendiri)
              TextFormField(
                controller: _kelasController,
                decoration: InputDecoration(
                  labelText: 'Kelas',
                  hintText: 'Contoh: 1A, 3B, Reguler Pagi',
                  prefixIcon: const Icon(Icons.class_),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Kelas wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),

              // 8. Jenis Kelamin (Radio)
              const Text(
                'Jenis Kelamin',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              RadioListTile<String>(
                title: const Text('Laki-laki'),
                value: 'Laki-laki',
                groupValue: _jenisKelamin,
                onChanged: (String? value) {
                  setState(() {
                    _jenisKelamin = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Perempuan'),
                value: 'Perempuan',
                groupValue: _jenisKelamin,
                onChanged: (String? value) {
                  setState(() {
                    _jenisKelamin = value;
                  });
                },
              ),
              const SizedBox(height: 12),

              // 9. Hobi (Checkbox - boleh lebih dari satu + Opsi Lainnya)
              const Text(
                'Hobi (boleh lebih dari satu)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              CheckboxListTile(
                title: const Text('Membaca'),
                value: _hobiMembaca,
                onChanged: (bool? value) {
                  setState(() {
                    _hobiMembaca = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Musik'),
                value: _hobiMusik,
                onChanged: (bool? value) {
                  setState(() {
                    _hobiMusik = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Olahraga'),
                value: _hobiOlahraga,
                onChanged: (bool? value) {
                  setState(() {
                    _hobiOlahraga = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Fotografi'),
                value: _hobiFotografi,
                onChanged: (bool? value) {
                  setState(() {
                    _hobiFotografi = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Opsi Lainnya'),
                value: _hobiLainnya,
                onChanged: (bool? value) {
                  setState(() {
                    _hobiLainnya = value ?? false;
                  });
                },
              ),
              if (_hobiLainnya) ...[
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  child: TextFormField(
                    controller: _hobiLainnyaController,
                    decoration: InputDecoration(
                      labelText: 'Sebutkan Hobi Lainnya',
                      hintText: 'Contoh: Coding, Gaming, Otomotif',
                      prefixIcon: const Icon(Icons.edit),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (String? value) {
                      if (_hobiLainnya &&
                          (value == null || value.trim().isEmpty)) {
                        return 'Tuliskan hobi lainnya jika opsi dicentang';
                      }
                      return null;
                    },
                  ),
                ),
              ],
              const SizedBox(height: 12),

              // 10. Text Area / Alamat & Catatan
              TextField(
                controller: _alamatController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Alamat / Catatan Tambahan',
                  hintText: 'Tuliskan alamat atau catatan...',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 11. Persetujuan Syarat & Ketentuan
              CheckboxListTile(
                title: const Text('Saya menyetujui syarat dan ketentuan'),
                controlAffinity: ListTileControlAffinity.leading,
                value: _setujuSyarat,
                onChanged: (bool? value) {
                  setState(() {
                    _setujuSyarat = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Tombol Simpan
              ElevatedButton(
                onPressed: _simpanForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
