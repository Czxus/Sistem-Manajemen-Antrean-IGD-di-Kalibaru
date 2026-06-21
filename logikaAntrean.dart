import 'queue.dart';
import 'pasien.dart';
import 'urgensi.dart';

class LogikaAntrean {
  final CustomQueue<Pasien> antreanMerah = CustomQueue<Pasien>();
  final CustomQueue<Pasien> antreanKuning = CustomQueue<Pasien>();
  final CustomQueue<Pasien> antreanHijau = CustomQueue<Pasien>();

  void tambahKeAntrean(Pasien pasien) {
    switch (pasien.tingkatUrgensi) {
      case TingkatUrgensi.MERAH:
        antreanMerah.enqueue(pasien);
        break;
      case TingkatUrgensi.KUNING:
        antreanKuning.enqueue(pasien);
        break;
      case TingkatUrgensi.HIJAU:
        antreanHijau.enqueue(pasien);
        break;
    }
  }

  Pasien? panggilPasienBerikutnya() {
    if (!antreanMerah.isEmpty) {
      Pasien? pasien = antreanMerah.dequeue();
      if (pasien != null) pasien.status = "Selesai Ditangani";
      return pasien;
    }
    
    if (!antreanKuning.isEmpty) {
      Pasien? pasien = antreanKuning.dequeue();
      if (pasien != null) pasien.status = "Selesai Ditangani";
      return pasien;
    }
    
    if (!antreanHijau.isEmpty) {
      Pasien? pasien = antreanHijau.dequeue();
      if (pasien != null) pasien.status = "Selesai Ditangani";
      return pasien;
    }
    
    return null;
  }

  Pasien? lihatPasienTerdepan() {
    if (!antreanMerah.isEmpty) return antreanMerah.peek();
    if (!antreanKuning.isEmpty) return antreanKuning.peek();
    if (!antreanHijau.isEmpty) return antreanHijau.peek();
    return null;
  }
}