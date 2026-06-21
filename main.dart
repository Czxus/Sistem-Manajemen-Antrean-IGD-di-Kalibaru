import 'dart:io';
import 'pasien.dart';
import 'urgensi.dart';
import 'logikaAntrean.dart';
import 'pencarian.dart';
import 'penyortiran.dart';
import 'menyimpanData.dart';

void main() {
  List<Pasien> databasePasien = MenyimpanData.bacaDariCsv();
  LogikaAntrean manajemenAntrean = LogikaAntrean();

  for (int i = 0; i < databasePasien.length; i++) {
    if (databasePasien[i].status == "Dalam Antrean") {
      manajemenAntrean.tambahKeAntrean(databasePasien[i]);
    }
  }

  bool berjalan = true;

  while (berjalan) {
    print('\nPILH LAYANAN IGD');
    print('1. Daftarkan Pasien Baru (Enqueue)');
    print('2. Panggil Pasien Berikutnya (Dequeue)');
    print('3. Lihat Pasien Terdepan (Peek)');
    print('4. Tampilkan Semua Riwayat Pasien');
    print('5. Cari Data Pasien (Linear Search)');
    print('6. Urutkan Pasien berdasarkan Usia (Bubble Sort)');
    print('7. Keluar');
    stdout.write('Pilih menu (1-7): ');
    String? pilihan = stdin.readLineSync();

    switch (pilihan) {
      case '1':
        print('\nInput Data Pasien');
        stdout.write('Nama: ');
        String nama = stdin.readLineSync() ?? 'Tanpa Nama';
        
        stdout.write('Usia: ');
        int usia = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;

        print('Pilih Urgensi: 1. MERAH, 2. KUNING, 3. HIJAU');
        stdout.write('Pilihan (1-3): ');
        String pilihanUrgensi = stdin.readLineSync() ?? '3';
        
        TingkatUrgensi urgensi;
        if (pilihanUrgensi == '1') {
          urgensi = TingkatUrgensi.MERAH;
        } else if (pilihanUrgensi == '2') {
          urgensi = TingkatUrgensi.KUNING;
        } else {
          urgensi = TingkatUrgensi.HIJAU;
        }

        stdout.write('Keluhan: ');
        String keluhan = stdin.readLineSync() ?? '-';

        String idPasien = 'IGD-' + (databasePasien.length + 1).toString();

        Pasien pasienBaru = Pasien(idPasien, nama, usia, urgensi, keluhan, "Dalam Antrean");

        databasePasien.add(pasienBaru);
        manajemenAntrean.tambahKeAntrean(pasienBaru);
        MenyimpanData.simpanKeCsv(databasePasien);

        print('Pasien berhasil didaftarkan dengan ID: $idPasien');
        break;

      case '2':
        print('\nMemanggil Pasien');
        Pasien? dipanggil = manajemenAntrean.panggilPasienBerikutnya();

        if (dipanggil != null) {
          print('Silakan Masuk: ${dipanggil.nama} [ID: ${dipanggil.id}]');
          
          for (int i = 0; i < databasePasien.length; i++) {
            if (databasePasien[i].id == dipanggil.id) {
              databasePasien[i].status = "Selesai Ditangani";
              break;
            }
          }
          MenyimpanData.simpanKeCsv(databasePasien);
        } else {
          print('Semua antrean kosong, tidak ada pasien.');
        }
        break;

      case '3':
        print('\nPasien Terdepan Saat Ini');
        Pasien? terdepan = manajemenAntrean.lihatPasienTerdepan();
        if (terdepan != null) {
          print('Pasien berikutnya: ${terdepan.nama} (Kategori: ${terdepan.tingkatUrgensi.name})');
        } else {
          print('Tidak ada antrean.');
        }
        break;

      case '4':
        print('\nSemua Riwayat Pasien');
        if (databasePasien.isEmpty) {
          print('Databacobse masih kosong.');
        } else {
          for (int i = 0; i < databasePasien.length; i++) {
            Pasien p = databasePasien[i];
            print('${i + 1}. ID: ${p.id} | Nama: ${p.nama} | Usia: ${p.usia} Thn | Urgensi: ${p.tingkatUrgensi.name} | Status: ${p.status}');
          }
        }
        break;

      case '5':
        print('\nCari Pasien');
        stdout.write('Masukkan nama pasien yang dicari: ');
        String namaCari = stdin.readLineSync() ?? '';
        
        List<Pasien> hasil = Pencarian.cariBerdasarkanNama(databasePasien, namaCari);
        
        if (hasil.isNotEmpty) {
          print('Ditemukan ${hasil.length} data:');
          for (int i = 0; i < hasil.length; i++) {
            print('- ID: ${hasil[i].id} | Nama: ${hasil[i].nama} | Status: ${hasil[i].status}');
          }
        } else {
          print('Pasien dengan nama "$namaCari" tidak ditemukan.');
        }
        break;

      case '6':
        print('\nPengurutan Data');
        if (databasePasien.isEmpty) {
          print('Tidak ada data untuk diurutkan.');
        } else {
          Penyortiran.urutkanBerdasarkanUsiaKelebihan(databasePasien);
          MenyimpanData.simpanKeCsv(databasePasien);
          print('Data selesai diurutkan dari yang tertua ke termuda.');
          print('Silakan cek Menu 4 untuk melihat hasilnya.');
        }
        break;

      case '7':
        print('\nKeluar dari sistem. Terima kasih!');
        berjalan = false;
        break;

      default:
        print('Pilihan salah, masukkan angka 1 sampai 7.');
    }
  }
}