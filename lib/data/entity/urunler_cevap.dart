import 'package:bitirme_projesi/data/entity/urunler.dart';

class UrunlerCevap {
  List<Yemekler> yemekler;
  int success;

  UrunlerCevap({
    required this.yemekler,
    required this.success,
  });

  factory UrunlerCevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["yemekler"] as List;
    int success = json["success"] as int;

    var yemekler = jsonArray
        .map((jsonArrayNesnesi) => Yemekler.fromJson(jsonArrayNesnesi))
        .toList();

    return UrunlerCevap(
      yemekler: yemekler,
      success: success,
    );
  }
}
