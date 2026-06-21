import 'person.dart';
import 'urgensi.dart';

class Pasien extends Person {
  TingkatUrgensi tingkatUrgensi;
  String _keluhan; 
  String status;  

  Pasien(
    String id, 
    String nama, 
    int usia, 
    this.tingkatUrgensi, 
    this._keluhan, 
    this.status
  ) : super(id, nama, usia);

  String get keluhan => _keluhan;

  set keluhan(String value) {
    if (value.trim().isNotEmpty) {
      _keluhan = value;
    }
  }

  @override
  void tampilkanInfo() {
    print('Data Pasien');
    print('ID Pasien      : $id');
    print('Nama Pasien    : $nama');
    print('Usia           : $usia Tahun');
    print('Tingkat Urgensi: ${tingkatUrgensi.name}');
    print('Keluhan        : $_keluhan');
    print('Status Pasien  : $status');
  }
}