import 'package:bitirme_projesi/data/entity/sepet_urunler.dart';

class SepetUrunlerCevap {
  List<SepetUrunler> sepet_yemekler;
  int success;

  SepetUrunlerCevap({
    required this.sepet_yemekler,
    required this.success,
  });

  factory SepetUrunlerCevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["sepet_yemekler"] as List;
    int success = json["success"] as int;

    var sepet_yemekler = jsonArray.map((jsonArrayNesnesi) => SepetUrunler.fromJson(jsonArrayNesnesi)).toList();

    return SepetUrunlerCevap(sepet_yemekler: sepet_yemekler, success: success);
  }
}
