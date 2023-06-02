import 'package:flutter/material.dart';
import 'package:sisform_transaksi_stok_gas/widget/firebase/connection.dart';
import 'package:sisform_transaksi_stok_gas/widget/subWidget/view_data.dart';
import 'package:intl/intl.dart';

class TabViewController extends StatefulWidget {
  const TabViewController({Key? key, this.path}) : super(key: key);
  final String? path;

  @override
  _TabViewControllerState createState() => _TabViewControllerState();
}

class _TabViewControllerState extends State<TabViewController> {
  String? _firstDate;
  String? _lastDate;

  @override
  Widget build(BuildContext context) {
    final DateTime dateTime = DateTime.utc(
        DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final arguments =
        ModalRoute.of(context)!.settings.arguments as TabViewController;
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text('ViewData ${arguments.path}'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Custom'),
              Tab(text: 'Harian'),
              Tab(text: 'Mingguan'),
              Tab(text: 'Bulanan'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            DateTime? firstDate = await showDatePicker(
                              context: context,
                              initialDate: dateTime,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(DateTime.now().year + 1),
                            );
                            setState(() {
                              _firstDate = dateFormat.format(firstDate!);
                              debugPrint(_firstDate);
                            });
                          },
                          child: const Text('Choose First date')),
                      const SizedBox(
                        width: 50,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            DateTime? endDate = await showDatePicker(
                              context: context,
                              initialDate: dateTime,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(DateTime.now().year + 1),
                            );
                            setState(() {
                              _lastDate = dateFormat.format(endDate!);
                            });
                          },
                          child: const Text('Choose End Date')),
                    ],
                  ),
                ),
                _firstDate != null && _lastDate != null
                    ? Expanded(
                        child: ViewData(
                          path: arguments.path,
                          tabView: 'Custom',
                          //stream: () => readData(path: arguments.path!),
                          stream: readData(
                            path: arguments.path!,
                            first: _firstDate,
                            end: _lastDate,
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
            ViewData(
              path: arguments.path,
              tabView: 'Harian',
              //stream: () => readDataDays(path: arguments.path!),
              stream: readDataDays(path: arguments.path!),
            ),
            ViewData(
              path: arguments.path,
              tabView: 'Mingguan',
              //stream: () => readDataWeekdays(path: arguments.path!),
              stream: readDataWeekdays(path: arguments.path!),
            ),
            ViewData(
              path: arguments.path,
              tabView: 'Bulanan',
              //stream: () => readDataMonth(path: arguments.path!),
              stream: readDataMonth(path: arguments.path!),
            ),
          ],
        ),
      ),
    );
  }
}
