import 'package:bitirme_projesi/data/entity/sepet_urunler.dart';
import 'package:bitirme_projesi/data/entity/urunler.dart';
import 'package:bitirme_projesi/ui/cubit/anasayfa_cubit.dart';
import 'package:bitirme_projesi/ui/cubit/sepetsayfa_cubit.dart';
import 'package:bitirme_projesi/ui/views/detay.dart';
import 'package:bitirme_projesi/ui/views/sepet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({Key? key}) : super(key: key);

  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  String _value = "Ev Adresi";
  TextEditingController controller = TextEditingController();
  int currentIndex = 0;

  bool aramaYapiliyorMu = false;

  @override
  void initState() {
    super.initState();
    context.read<AnaSayfaCubit>().urunleriGoster();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        //leading: Container(),
        title: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.deepPurple.withOpacity(0.35),
            border: Border.all(color: Colors.deepPurple, width: 2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 30),
            child: DropdownButton(
              value: _value,
              borderRadius: BorderRadius.circular(12.0),
              items: const <DropdownMenuItem<String>>[
                DropdownMenuItem(
                  value: "Ev Adresi",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.deepPurple,
                      ),
                      SizedBox(width: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Teslim Adresi",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                          Text(
                            "Ev Adresi",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: "Is Adresi",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.deepPurple,
                      ),
                      SizedBox(width: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Teslim Adresi",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                          Text(
                            "Is Adresi",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _value = value!;
                });
              },
              icon: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Colors.deepPurple,
                ),
              ),
              iconEnabledColor: Colors.white, //Icon color
              style: const TextStyle(
                  //te
                  color: Colors.white, //Font color
                  fontSize: 20 //font size on dropdown button
                  ),
              dropdownColor: Colors.deepPurple.shade200,
              underline: Container(), //remove underline
              isExpanded: true,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.messenger_outline_outlined, size: 22),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.airplane_ticket_outlined, size: 22),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<AnaSayfaCubit, List<Yemekler>>(
          builder: (context, urunlerListesi) {
            if (urunlerListesi.isNotEmpty) {
              return Expanded(
                child: GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 1 / 1.5),
                  itemCount: urunlerListesi.length,
                  itemBuilder: (context, index) {
                    var urun = urunlerListesi[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetaySayfa(yemekler: urun),
                            ));
                      },
                      child: Card(
                        color: Colors.white70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.network(
                                "http://kasimadalan.pe.hu/yemekler/resimler/${urun.yemek_resim_adi}"),
                            Text(urun.yemek_adi,
                                style: const TextStyle(fontSize: 22)),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("₺ ${urun.yemek_fiyat}",
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetaySayfa(yemekler: urun)));
                                      },
                                      icon: const Icon(
                                        Icons.add_box,
                                        size: 40,
                                      ),
                                      color: Colors.deepPurple),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center();
            }
          },
        ),
      ),
      /*
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () {
        },
        child: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      */
        bottomNavigationBar: BottomAppBar(
          color: Colors.deepPurple,
          shape: const CircularNotchedRectangle(),
          notchMargin: 7,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.home_outlined, color: Colors.white)),
              IconButton(
                  onPressed: () {
                  },
                  icon: const Icon(Icons.favorite, color: Colors.white)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person, color: Colors.white)),
              /*
              Padding(
                padding: const EdgeInsets.only(right: 90.0),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.person, color: Colors.white)),
                    ),
                */
            ],
          )),
    );
  }
}
