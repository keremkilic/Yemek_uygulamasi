import 'package:bitirme_projesi/data/repo/urunlerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetaySayfaCubit extends Cubit<void> {
  DetaySayfaCubit(): super(0);

  var urunRepo = UrunlerDaoRepository();

  Future<void> sepeteYemekEkle(String yemek_adi, String yemek_resim_adi, int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi) async {
    await urunRepo.sepeteYemekEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);

  }

}