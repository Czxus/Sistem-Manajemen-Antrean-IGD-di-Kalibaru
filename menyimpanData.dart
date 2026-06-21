import 'dart:io';
import 'pasien.dart';
import 'urgensi.dart';

class MenyimpanData {
  static const String namaFile = 'daftarPasien.csv';

  static void simpanKeCsv(List<Pasien> daftarPasien) {
    try {
      final File file = File(namaFile);
      final List<String> barisData = [];

      barisData.add('id,nama,usia,tingkat_urgensi,keluhan,status');

      for (int i = 0; i < daftarPasien.length; i++) {
        Pasien p = daftarPasien[i];

        String keluhanAman = p.keluhan.replaceAll(',', ';');
        String namaAman = p.nama.replaceAll(',', ';');

        barisData.add('${p.id},$namaAman,${p.usia},${p.tingkatUrgensi.name},$keluhanAman,${p.status}');
      }

      file.writeAsStringSync(barisData.join('\n'));
      print('Data berhasil disinkronisasi ke $namaFile.');
    } catch (e) {
      print('Gagal menyimpan data ke CSV: $e');
    }
  }

  static List<Pasien> bacaDariCsv() {
    List<Pasien> hasilDaftar = [];
    try {
      final File file = File(namaFile);

      if (!file.existsSync()) {
        return hasilDaftar;
      }

      List<String> barisData = file.readAsLinesSync();

      if (barisData.length <= 1) {
        return hasilDaftar;
      }

      for (int i = 1; i < barisData.length; i++) {
        String baris = barisData[i].trim();
        if (baris.isEmpty) continue; 

        List<String> kolom = baris.split(',');

        if (kolom.length == 6) {
          String id = kolom[0];
          String nama = kolom[1];
          int usia = int.parse(kolom[2]);
          
          TingkatUrgensi urgensi = TingkatUrgensi.values.firstWhere(
            (e) => e.name == kolom[3],
            orElse: () => TingkatUrgensi.HIJAU,
          );
          
          String keluhan = kolom[4];
          String status = kolom[5];

          hasilDaftar.add(Pasien(id, nama, usia, urgensi, keluhan, status));
        }
      }
    } catch (e) {
      print('Gagal membaca data dari CSV: $e');
    }
    return hasilDaftar;
  }
}