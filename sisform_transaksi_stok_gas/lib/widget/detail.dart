import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sisform_transaksi_stok_gas/widget/subWidget/tambah_data.dart';
import 'package:sisform_transaksi_stok_gas/widget/tab_view_controller.dart';

import 'auth/auth.dart';

class Detail extends StatelessWidget {
  Detail({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _userUID() {
    return Text(user?.email ?? "user email");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _userUID(),
        actions: [
          IconButton(
            onPressed: () {
              signOut();
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            icon: const Icon(Icons.logout, color: Colors.white),
            splashColor: Colors.red,
          ),
        ],
      ),
      body: Column(
        children: [
          // TODO : 3 KG
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Image.asset(
                    'assets/gas-3-kg.png',
                    width: 100,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '3 Kg',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                            'Gas ini diperuntukkan untuk subsidi masyarakat kelas kebawah dan usaha level kecil'),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/tambah_data',
                                  arguments: TambahData(
                                    path: '3 kg',
                                  ),
                                );
                              },
                              child: const Text(
                                'Add Data',
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/tab-view',
                                  arguments: const TabViewController(
                                    path: '3 kg',
                                  ),
                                );
                              },
                              child: const Text('View Data'),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          // TODO : 5 KG
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Image.asset(
                    'assets/gas-5.5-kg.png',
                    width: 100,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '5.5 Kg',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                            'Bright Gas ini sangat cocok untuk keluarga kecil atau baru berkeluarga'),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/tambah_data',
                                  arguments: TambahData(
                                    path: '5.5 kg',
                                  ),
                                );
                              },
                              child: const Text(
                                'Add Data',
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/tab-view',
                                    arguments: const TabViewController(
                                      path: '5.5 kg',
                                    ),
                                  );
                                },
                                child: const Text('View Data')),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          // TODO : 12 KG
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Image.asset(
                    'assets/gas-12-kg.png',
                    width: 100,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '12 Kg',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                            'Gas ini sangat cocok untuk dipakai di keluarga besar (anggota lebih dari 4 orang)'),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/tambah_data',
                                  arguments: TambahData(
                                    path: '12 kg',
                                  ),
                                );
                              },
                              child: const Text(
                                'Add Data',
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/tab-view',
                                    arguments: const TabViewController(
                                      path: '12 kg',
                                    ),
                                  );
                                },
                                child: const Text('View Data')),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
