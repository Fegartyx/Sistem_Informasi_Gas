import 'package:flutter/material.dart';
import 'package:sisform_transaksi_stok_gas/widget/detail.dart';
import 'package:sisform_transaksi_stok_gas/widget/info_perusahaan.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Widget> body = [
    Detail(),
    const InfoPerusahaan(),
    // const Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Detail'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
          //BottomNavigationBarItem(icon: Icon(Icons.auto_graph), label: 'Grafik'),
        ],
      ),
    );
  }
}
