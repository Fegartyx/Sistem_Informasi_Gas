import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../firebase/connection.dart';

class EditData extends StatelessWidget {
  EditData(
      {Key? key,
      this.id,
      this.sbDatang_sisa,
      this.sbHarga,
      this.sbLaku,
      this.sbDate,
      this.path})
      : super(key: key);
  final String? id;
  final String? path;
  final int? sbDatang_sisa;
  final int? sbHarga;
  final int? sbLaku;
  final DateTime? sbDate;
  final _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as EditData;
    TextEditingController datang_sisaController =
        TextEditingController(text: arguments.sbDatang_sisa.toString());
    TextEditingController harga =
        TextEditingController(text: arguments.sbHarga.toString());
    TextEditingController laku =
        TextEditingController(text: arguments.sbLaku.toString());
    TextEditingController date = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(arguments.sbDate!));

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
                    lastDate: DateTime(DateTime.now().year + 1),
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
                    // do Something
                    if (_formState.currentState!.validate()) {
                      editData(
                        path: arguments.path!,
                        id: arguments.id!,
                        laku: int.tryParse(laku.text)!,
                        harga: int.tryParse(harga.text)!,
                        datang_sisa: int.tryParse(datang_sisaController.text)!,
                        date: DateTime.parse(date.text),
                      );
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
  InputData({
    Key? key,
    required this.controller,
    required this.label,
    this.value,
    this.textInputType,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType? textInputType;
  var value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == '') {
          return 'Field Tidak Boleh Kosong';
        }
      },
      initialValue: value,
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
