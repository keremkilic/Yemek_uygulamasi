import 'package:bitirme_projesi/data/entity/urunler.dart';
import 'package:bitirme_projesi/ui/cubit/detaysayfa_cubit.dart';
import 'package:bitirme_projesi/ui/views/sepet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetaySayfa extends StatefulWidget {
  Yemekler yemekler;
  DetaySayfa({required this.yemekler});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var adet = 0;
  var ucret = 0;
  bool isVisible = false;

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
          "Ürün Detay",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.favorite_outlined))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("PUANLAMA YAPILACAK YILDIZ KOY"),
            Image.network(
                "http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemekler.yemek_resim_adi}"),
            Text(
              "₺ ${widget.yemekler.yemek_fiyat}",
              style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
            Text(
              "${widget.yemekler.yemek_adi}",
              style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (adet < 1) {
                        adet = 0;
                      } else {
                        adet = adet - 1;
                        if (adet == 0) {
                          isVisible = false;
                        } else {
                          isVisible = true;
                        }
                      }

                      var fiyat = int.parse(widget.yemekler.yemek_fiyat);
                      ucret = fiyat * adet;
                    });
                  },
                  icon: const Icon(
                    Icons.indeterminate_check_box_rounded,
                    size: 40,
                  ),
                  color: Colors.deepPurple,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    adet.toString(),
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        adet = adet + 1;
                        isVisible = true;
                        var fiyat = int.parse(widget.yemekler.yemek_fiyat);
                        ucret = fiyat * adet;
                      });
                    },
                    icon: const Icon(
                      Icons.add_box,
                      size: 40,
                    ),
                    color: Colors.deepPurple),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildContainer("25 - 30 dk"),
                  buildContainer("Ücretsiz Teslimat"),
                  buildContainer("%20 İndirim"),
                ],
              ),
            ),
            Text(
              "Toplam Ücret : $ucret ₺ ",
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFCB2020)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SepetSayfa(
                        yemek: widget.yemekler,
                        adet: adet,
                        kullanici_adi: "klckrm",
                      ),
                    ));
                context.read<DetaySayfaCubit>().sepeteYemekEkle(
                    widget.yemekler.yemek_adi,
                    widget.yemekler.yemek_resim_adi,
                    int.parse(widget.yemekler.yemek_fiyat),
                    adet,
                    "klckrm");
              },
              child: const Text(
                "Sepete Ekle",
                style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(250, 50),
                backgroundColor: Colors.deepPurple,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildContainer(String title) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade400,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Text(
          title,
          style: const TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
