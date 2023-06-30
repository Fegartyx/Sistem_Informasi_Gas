import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sisform_transaksi_stok_gas/widget/firebase/connection.dart';

import '../tab_view_controller.dart';

class TambahData extends StatelessWidget {
  TambahData({Key? key, this.path}) : super(key: key);
  final String? path;
  TextEditingController datang_sisaController = TextEditingController();
  TextEditingController harga = TextEditingController();
  TextEditingController laku = TextEditingController();
  TextEditingController date = TextEditingController();
  final _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as TambahData;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _formState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InputData(
                controller: datang_sisaController,
                label: 'datang/sisa',
                textInputType: TextInputType.number,
              ),
              const SizedBox(
                height: 15,
              ),
              InputData(
                controller: harga,
                label: 'harga',
                textInputType: TextInputType.number,
              ),
              const SizedBox(
                height: 15,
              ),
              InputData(
                controller: laku,
                label: 'laku',
                textInputType: TextInputType.number,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: date,
                decoration: InputDecoration(
                  labelText: 'Select Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onTap: () async {
                  DateTime? pickDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (pickDate != null) {
                    date.text = DateFormat('yyyy-MM-dd').format(pickDate);
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    try {
                      if (_formState.currentState!.validate()) {
                        if (int.parse(laku.text) <
                            int.parse(datang_sisaController.text)) {
                          createData(
                            path: arguments.path!,
                            laku: int.tryParse(laku.text)!,
                            harga: int.tryParse(harga.text)!,
                            datang_sisa:
                                int.tryParse(datang_sisaController.text)!,
                            date: DateTime.parse(date.text),
                          );
                          Navigator.pushReplacementNamed(
                            context,
                            '/tab-view',
                            arguments: const TabViewController(
                              path: '3 kg',
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Invalid Laku Value'),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(e.toString()),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InputData extends StatelessWidget {
  const InputData({
    Key? key,
    required this.controller,
    required this.label,
    this.textInputType,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType? textInputType;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == '') {
          return 'Field Tidak Boleh Kosong';
        }
      },
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
