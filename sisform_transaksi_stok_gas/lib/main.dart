import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sisform_transaksi_stok_gas/widget/home.dart';
import 'package:sisform_transaksi_stok_gas/widget/info_perusahaan.dart';
import 'package:sisform_transaksi_stok_gas/widget/subWidget/edit_data.dart';
import 'package:sisform_transaksi_stok_gas/widget/subWidget/view_data.dart';
import 'package:sisform_transaksi_stok_gas/widget/subWidget/tambah_data.dart';
import 'package:sisform_transaksi_stok_gas/widget/tab_view_controller.dart';
import 'package:sisform_transaksi_stok_gas/widget/widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/': (context) => const WidgetTree(),
        '/home': (context) => const Home(),
        '/info': (context) => const InfoPerusahaan(),
        '/tab-view': (context) => const TabViewController(),
        '/view_data': (context) => const ViewData(),
        '/tambah_data': (context) => TambahData(),
        '/edit_data': (context) => EditData(),
      },
    );
  }
}
