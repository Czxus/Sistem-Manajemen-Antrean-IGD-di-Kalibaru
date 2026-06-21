import 'person.dart';

class Dokter extends Person {
  String spesialisasi;

  Dokter(String id, String nama, int usia, this.spesialisasi) : super(id, nama, usia);

  @override
  void tampilkanInfo() {
    print('Data Dokter');
    print('ID Dokter     : $id');
    print('Nama Dokter   : $nama');
    print('Usia          : $usia Tahun');
    print('Spesialisasi  : $spesialisasi');
  }
}