import 'package:bitirme_projesi/data/entity/sepet_urunler.dart';
import 'package:bitirme_projesi/data/entity/urunler.dart';
import 'package:bitirme_projesi/ui/cubit/sepetsayfa_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SepetSayfa extends StatefulWidget {
  Yemekler yemek;
  int adet;
  String kullanici_adi;

  SepetSayfa(
      {required this.yemek, required this.adet, required this.kullanici_adi});

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  num toplam = 0;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().sepettekiYemekler("klckrm");
    toplam = int.parse(widget.yemek.yemek_fiyat) * (widget.adet);
  }

  Future<bool> anaSayfayaGeriDon(BuildContext context) async {
    Navigator.of(context).popUntil((route) => route.isFirst);
    toplam = 0;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.clear)),
        title: const Text(
          "Sepetim",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<SepetSayfaCubit, List<SepetUrunler>>(
        builder: (context, sepetYemekListesi) {
          if (sepetYemekListesi.isNotEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: sepetYemekListesi.length,
                    itemBuilder: (context, index) {
                      var yemek = sepetYemekListesi[index];
                      toplam = int.parse(sepetYemekListesi[index].yemek_fiyat) *
                          int.parse(
                              sepetYemekListesi[index].yemek_siparis_adet);
                      return Slidable(
                        endActionPane:
                            ActionPane(motion: const BehindMotion(), children: [
                          SlidableAction(
                            onPressed: (context) {
                              setState(() {
                                context.read<SepetSayfaCubit>().sil(int.parse(yemek.sepet_yemek_id),yemek.kullanici_adi);
                              });
                            },
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            label: "Sil",
                          ),
                        ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.white70,
                            child: SizedBox(
                              height: 120,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.network(
                                      "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          yemek.yemek_adi,
                                          style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Fiyat : ₺ ${yemek.yemek_fiyat}",
                                          style: const TextStyle(fontSize: 19),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${(int.parse(yemek.yemek_fiyat) * widget.adet)} ₺"
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (widget.adet < 1) {
                                                  widget.adet = 0;
                                                } else {
                                                  widget.adet = widget.adet - 1;
                                                  if (widget.adet == 0) {
                                                    isVisible = false;
                                                  } else {
                                                    isVisible = true;
                                                  }
                                                }
                                                var fiyat = int.parse(
                                                    widget.yemek.yemek_fiyat);
                                                toplam = fiyat * widget.adet;
                                              });

                                            },
                                            icon: const Icon(
                                              Icons
                                                  .indeterminate_check_box_rounded,
                                              size: 25,
                                            ),
                                            color: Colors.deepPurple,
                                          ),
                                          Text(
                                            widget.adet.toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  widget.adet = widget.adet + 1;
                                                  isVisible = true;
                                                  var fiyat = int.parse(
                                                      widget.yemek.yemek_fiyat);
                                                  toplam = fiyat * widget.adet;
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.add_box,
                                                size: 25,
                                              ),
                                              color: Colors.deepPurple),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 75),
                  child: Container(
                    height: 25,
                    child: Text(
                      "Toplam ücret : ₺ $toplam",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center();
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(
          onPressed: () {
            print("Sepetteki ürünler hazırlaniyor");
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  icon: Icon(
                    Icons.track_changes_outlined,
                    size: 32,
                    color: Colors.blue,
                  ),
                  title: Text("Bilgi"),
                  content: Text("Sepetteki ürünler hazırlaniyor"),
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
              minimumSize: Size(250, 50), backgroundColor: Colors.deepPurple),
          child: const Text(
            "Sepeti Onayla",
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
