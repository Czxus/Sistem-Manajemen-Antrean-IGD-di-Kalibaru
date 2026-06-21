import 'pasien.dart';

class Penyortiran {
  static void urutkanBerdasarkanUsiaKelebihan(List<Pasien> daftarPasien) {
    int n = daftarPasien.length;
    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        if (daftarPasien[j].usia < daftarPasien[j + 1].usia) {
          Pasien temp = daftarPasien[j];
          daftarPasien[j] = daftarPasien[j + 1];
          daftarPasien[j + 1] = temp;
        }
      }
    }
  }
}