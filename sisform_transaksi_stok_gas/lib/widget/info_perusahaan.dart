import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class InfoPerusahaan extends StatelessWidget {
  const InfoPerusahaan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final images = [
      'assets/20230318_093011.jpg',
      'assets/20230318_093117.jpg',
      'assets/20230318_093159.jpg',
      'assets/20230318_093755.jpg'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Info'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          CarouselSlider.builder(
            options: CarouselOptions(
              height: 270,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              viewportFraction: 1,
              enlargeCenterPage: true,
            ),
            itemCount: images.length,
            itemBuilder: (context, index, realIndex) {
              final image = images[index];
              return buildImage(index, image);
            },
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'PT Maryn adalah salah satu unit usaha yang bergerak di bidang perdagangan. '
            'Salah satu usahanya adalah mitra dagang Pertamina dalam mendistirbusikan gas Elpiji. '
            'Pangkalan ini memperoleh izin untuk mendistribusikan gas Elpiji dari yang berwenang, '
            'area usaha berada di Batang Kuis, Jalan Pancasila Dusun III. '
            'Pangkalan ini didirikan pada tanggal 26 Januari 2018 oleh Bapak Mahmud R Siregar.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget buildImage(int index, String images) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      color: Colors.grey,
      child: Image.asset(images),
      // child: Image.network(src,fit: BoxFit.cover,),
    );
  }
}
