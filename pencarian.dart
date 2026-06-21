import 'pasien.dart';

class Pencarian {
  static Pasien? cariBerdasarkanId(List<Pasien> daftarPasien, String idDicari) {
    String targetId = idDicari.trim().toLowerCase();
    
    for (int i = 0; i < daftarPasien.length; i++) {
      if (daftarPasien[i].id.toLowerCase() == targetId) {
        return daftarPasien[i]; 
      }
    }
    return null; 
  }

  static List<Pasien> cariBerdasarkanNama(List<Pasien> daftarPasien, String namaDicari) {
    List<Pasien> hasilPencarian = [];
    String targetNama = namaDicari.trim().toLowerCase();

    for (int i = 0; i < daftarPasien.length; i++) {
      if (daftarPasien[i].nama.toLowerCase().contains(targetNama)) {
        hasilPencarian.add(daftarPasien[i]);
      }
    }
    return hasilPencarian;
  }
}