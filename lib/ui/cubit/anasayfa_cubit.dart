import 'package:bitirme_projesi/data/entity/urunler.dart';
import 'package:bitirme_projesi/data/repo/urunlerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnaSayfaCubit extends Cubit<List<Yemekler>> {
  AnaSayfaCubit() : super(<Yemekler>[]);

  var urunRepo = UrunlerDaoRepository();

  Future<void> urunleriGoster() async {
    var liste = await urunRepo.urunleriGoster();
    emit(liste);
  }

  Future<void> ara(String aramaKelimesi) async {
    var urunlerListesi = await urunRepo.ara(aramaKelimesi);
    emit(urunlerListesi);
  }
}
