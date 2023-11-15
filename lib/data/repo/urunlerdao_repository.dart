import 'dart:convert';

import 'package:bitirme_projesi/data/entity/sepet_urunler.dart';
import 'package:bitirme_projesi/data/entity/sepet_urunler_cevap.dart';
import 'package:bitirme_projesi/data/entity/urunler.dart';
import 'package:bitirme_projesi/data/entity/urunler_cevap.dart';
import 'package:dio/dio.dart';

class UrunlerDaoRepository {

  List<Yemekler> parseUrunler(String cevap) {
    return UrunlerCevap.fromJson(json.decode(cevap)).yemekler;
  }

  List<SepetUrunler> parseSepetUrunler(String cevap) {
      return SepetUrunlerCevap.fromJson(json.decode(cevap)).sepet_yemekler;
  }


  // Tum Urunler
  Future<List<Yemekler>> urunleriGoster() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseUrunler(cevap.data.toString());
  }

  // Ara
  Future<List<Yemekler>> ara(String aramaKelimesi) async {
    var url = "http://kasimadalan.pe.hu/kisiler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    var urunListe = parseUrunler(cevap.data.toString());
    Iterable<Yemekler> filtre = urunListe.where((urunNesnesi) => urunNesnesi.yemek_adi.contains(aramaKelimesi));
    var urunler = filtre.toList();
    return urunler;
  }

  // Sepete Yemek Ekle
  Future<void> sepeteYemekEkle(String yemek_adi, String yemek_resim_adi, int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {
      "yemek_adi" : yemek_adi,
      "yemek_resim_adi" : yemek_resim_adi,
      "yemek_fiyat" : yemek_fiyat,
      "yemek_siparis_adet" : yemek_siparis_adet,
      "kullanici_adi" : kullanici_adi,
    };

    print("Sepetteki Eklenenler : $veri");

    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print("Sepete Ekle : ${cevap.data.toString()} ");
  }

  // Sepetteki Yemekler
  Future<List<SepetUrunler>> sepettekiYemekler(String kullaniciAdi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi" : kullaniciAdi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    return parseSepetUrunler(cevap.data.toString());
  }

  Future<void> sil(int sepet_yemek_id, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {"sepet_yemek_id": sepet_yemek_id, "kullanici_adi" : kullanici_adi};
      var cevap = await Dio().post(url, data: FormData.fromMap(veri));
      print("Sepetteki Urunu Sil : ${cevap.data.toString()}");

  }



}