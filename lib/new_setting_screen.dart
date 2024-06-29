import 'package:flutter/material.dart';

class NewSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan', style:TextStyle(color: Colors.white),),
        backgroundColor: Colors.orange,
         iconTheme: IconThemeData(color: Colors.white),
      ),
     
      body: Container(
        color: Color.fromARGB(255, 32, 32, 32),
        child: ListView(
          children: [
            _buildSectionHeader('KUSTOMISASI WARNA'),
            _buildDivider(),
            _buildCheckboxListTile('Sesuaikan warna'),
            _buildCheckboxListTile('Sesuaikan warna widget'),
            _buildDivider(),
            _buildSectionHeader('GENERAL'),
            _buildCheckboxListTile('Gunakan bahasa Inggris'),
            _buildListTile('Kelola kategori acara'),
            _buildListTile('Kelola penyaringan cepat jenis peristiwa'),
            _buildCheckboxListTile('Gunakan format waktu 24 jam'),
            _buildCheckboxListTile('Awal pekan hari Minggu'),
            _buildCheckboxListTile('Sorot akhir pekan pada beberapa tampilan'),
            _buildDivider(),
            _buildSectionHeader('PENGINGAT'),
            _buildCheckboxListTile('Kustomisasi notifikasi'),
            _buildListTile('Audio yang digunakan pengingat'),
            _buildCheckboxListTile('Getar pada notifikasi'),
            _buildCheckboxListTile('Ulangi pengingat sampai dihentikan'),
            _buildCheckboxListTile('Selalu gunakan waktu tunda yang sama'),
            _buildListTile('Waktu Tunda'),
            _buildDivider(),
            _buildSectionHeader('CALLDAV'),
            _buildCheckboxListTile('Sinkronisasi CalDAV'),
            _buildDivider(),
            _buildSectionHeader('ACARA BARU'),
            _buildListTile('Waktu mulai default'),
            _buildListTile('Durasi default'),
            _buildListTile('Kategori acara default'),
            _buildCheckboxListTile('Gunakan pengingat acara sebelumnya sebagai pengingat acara baru'),
            _buildDivider(),
            _buildSectionHeader('TAMPILAN MINGGU'),
            _buildListTile('Hari dimulai pada jam'),
            _buildCheckboxListTile('Tampilkan peristiwa membentang sampai tengah malam di bilah atas'),
            _buildCheckboxListTile('Perbolehkan mengubah jumlah hari'),
            _buildCheckboxListTile('Mulai minggu dengan hari saat ini'),
            _buildDivider(),
            _buildSectionHeader('TAMPILAN BULAN'),
            _buildCheckboxListTile('Tampilkan nomor minggu'),
            _buildCheckboxListTile('Tampilkan grid'),
            _buildDivider(),
            _buildSectionHeader('DAFTAR ACARA'),
            _buildCheckboxListTile('Tampilkan acara yang sudah lewat'),
            _buildCheckboxListTile('Tampilkan deskripsi atau lokasi'),
            _buildCheckboxListTile('Ganti deskripsi acara dengan lokasi'),
            _buildDivider(),
            _buildSectionHeader('WIDGET'),
            _buildListTile('Ukuran Font'),
            _buildListTile('Yang akan ditampilkan saat membuka dari widget daftar acara'),
            _buildDivider(),
            _buildSectionHeader('ACARA'),
            _buildCheckboxListTile('Redupkan acara yang sudah lewat'),
            _buildCheckboxListTile('Izinkan mengubah zona waktu acara'),
            _buildListTile('Hapus semua acara dari catatan'),
            _buildDivider(),
            _buildSectionHeader('TUGAS'),
            _buildCheckboxListTile('Perbolehkan membuat tugas'),
            _buildCheckboxListTile('Redupkan tugas yang selesai'),
            _buildDivider(),
            _buildSectionHeader('MEMINDAHKAN'),
            _buildListTile('Ekspor Pengaturan'),
            _buildListTile('Impor Pengaturan'),
            _buildDivider(),
            _buildSectionHeader('OTHER'),
            _buildListTile('Nilai kami'),
            _buildListTile('Bagikan aplikasi'),
            _buildListTile('Dukungan pelanggan'),
            _buildListTile('Kebijakan privasi'),
            _buildListTile('Syarat dan ketentuan'),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Text(
        title,
        style: TextStyle(
          color: Color.fromARGB(246, 233, 141, 3),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey.withOpacity(0.5),
      thickness: 1,
    );
  }

  Widget _buildCheckboxListTile(String title) {
    return CheckboxListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white,  fontSize: 14),
      ),
      value: false, // Set initial value
      onChanged: (bool? value) {
        // Handle change
      },
    );
  }

  Widget _buildRadioListTile(String title) {
    return RadioListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white,fontSize: 14),
      ),
      value: false, // Set initial value
      groupValue: null, // Set initial group value
      onChanged: (value) {
        // Handle change
      },
    );
  }

  Widget _buildListTile(String title) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white,fontSize: 14),
      ),
      onTap: () {
        // Handle tap
      },
    );
  }
}
