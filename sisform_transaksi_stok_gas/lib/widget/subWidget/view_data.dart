import 'package:flutter/material.dart';
import 'package:sisform_transaksi_stok_gas/widget/firebase/connection.dart';
import 'package:sisform_transaksi_stok_gas/widget/subWidget/edit_data.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
//import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';

import '../class/gas.dart';
import '../tab_view_controller.dart';

class ViewData extends StatefulWidget {
  const ViewData({Key? key, this.path, this.stream, this.tabView})
      : super(key: key);
  final String? path;
  final String? tabView;
  //final Stream<List<Gas>> Function()? stream;
  final Stream<List<Gas>>? stream;

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final arguments =
        ModalRoute.of(context)!.settings.arguments as TabViewController;
    List<Gas>? data;
    Widget buildData(Gas gas) => Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Row(
                children: [
                  Text(
                      '${gas.date.day.toString()} - ${gas.date.month.toString()} \n${gas.date.year.toString()}'),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Gas yang terjual hari ini : ${gas.laku}'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            'Gas yang tersisa hari ini : ${gas.datang_sisa! - gas.laku!}'),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/edit_data',
                              arguments: EditData(
                                path: arguments.path,
                                id: gas.id,
                                sbDatang_sisa: gas.datang_sisa,
                                sbDate: gas.date,
                                sbHarga: gas.harga,
                                sbLaku: gas.laku,
                              ),
                            );
                          },
                          style: const ButtonStyle(
                            padding: MaterialStatePropertyAll(EdgeInsets.zero),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.orange),
                          ),
                          child: const Icon(Icons.edit),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            padding: MaterialStatePropertyAll(EdgeInsets.zero),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.red),
                          ),
                          onPressed: () {
                            deleteData(id: gas.id, path: arguments.path!);
                          },
                          child: const Icon(Icons.delete),
                        ),
                      ),
                    ],
                  ),
                  // ListTile(
                  //   leading: CircleAvatar(
                  //     child: Text(gas.laku.toString()),
                  //   ),
                  //   title: Text(
                  //       '${gas.harga} ${gas.total_akhir} ${gas.date} ${gas.datang_sisa} ${gas.id}'),
                  // ),
                ],
              ),
            ),
          ),
        );

    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Scaffold(
        body: StreamBuilder<List<Gas>>(
          //stream: stream!(),
          stream: widget.stream,
          builder: (context, snaphost) {
            if (snaphost.hasError) {
              return Text('Something Wrong! ${snaphost.error}');
            } else if (snaphost.hasData) {
              data = snaphost.data!;

              return ListView(
                children: data!.map(buildData).toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              debugPrint('press');
              await pdfCreation(data!, arguments);
            },
            child: const Icon(Icons.print)),
      ),
    );
  }

  pdfCreation(List<Gas> data, var arguments) async {
    final pdf = pw.Document();
    //final font = await PdfGoogleFonts.nunitoExtraLight();

    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Laporan ${widget.tabView} data gas ${arguments.path}'),
            pw.SizedBox(height: 25),
            pw.Table(
              border: pw.TableBorder.all(),
              children: [
                pw.TableRow(
                  children: [
                    pw.Text('No'),
                    pw.Text('Harga'),
                    pw.Text('Laku'),
                    pw.Text('Total'),
                    pw.Text('Date'),
                  ],
                ),
                ...data
                    .asMap()
                    .map(
                      (index, gas) {
                        return MapEntry(
                          index,
                          pw.TableRow(
                            children: [
                              pw.Text('${index + 1}'),
                              pw.Text(gas.harga.toString()),
                              pw.Text(gas.laku.toString()),
                              pw.Text(gas.total_akhir.toString()),
                              pw.Text(dateFormat.format(gas.date)),
                            ],
                          ),
                        );
                      },
                    )
                    .values
                    .toList(),
              ],
            ),
          ],
        ),
        pageFormat: PdfPageFormat.a4,
      ),
    );

    Directory dir = await getApplicationDocumentsDirectory();
    debugPrint(dir.toString());
    final path = '${dir.path}/example.pdf';
    final file = await File(path).writeAsBytes(await pdf.save());
    debugPrint(file.toString());

    await OpenFile.open(file.path);
  }
}
