import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sisform_transaksi_stok_gas/widget/home.dart';
import 'package:sisform_transaksi_stok_gas/widget/login.dart';

import '../main.dart';
import 'auth/auth.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  _WidgetTreeState createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  String? _token;
  String? initialMessage;
  bool _resolved = false;

  Future<void> setupInteractedMessage() async {
    FirebaseMessaging.instance.getInitialMessage().then(
          (value) => setState(
            () {
              _resolved = true;
              initialMessage = value?.data.toString();
            },
          ),
        );

    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('A new onMessageOpenedApp event was published!');
      Navigator.pushNamed(
        context,
        '/tambah_data',
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {
    /// TODO : Tempat untuk cek apakah user sudah login atau belum
    /// disini juga bisa dilakukan auth user sebagai apa
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const Home();
        } else {
          return const Login();
        }
      },
    );
  }
}
