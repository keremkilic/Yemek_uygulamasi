import 'package:bitirme_projesi/data/entity/sepet_urunler.dart';
import 'package:bitirme_projesi/data/repo/urunlerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetSayfaCubit extends Cubit<List<SepetUrunler>> {
  SepetSayfaCubit() : super(<SepetUrunler>[]);

  var urunRepo = UrunlerDaoRepository();

  Future<void> sepettekiYemekler(String kullanici_adi) async {
    var liste = await urunRepo.sepettekiYemekler(kullanici_adi);
    emit(liste);
  }

  Future<void> sil(int sepet_yemek_id, String kullanici_adi) async {
    await urunRepo.sil(sepet_yemek_id, kullanici_adi);
    sepettekiYemekler(kullanici_adi);
  }
}
