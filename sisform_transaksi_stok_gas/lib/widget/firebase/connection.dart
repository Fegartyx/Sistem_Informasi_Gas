import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../class/gas.dart';

Future createData(
    {required int datang_sisa,
    required int harga,
    required int laku,
    required DateTime date,
    required String path}) async {
  try {
    final docData = FirebaseFirestore.instance.collection(path).doc();

    final data = Gas(
      id: docData.id,
      total_akhir: harga * laku,
      datang_sisa: datang_sisa,
      harga: harga,
      laku: laku,
      date: date,
    );
    final json = data.toJson();
    debugPrint(json.toString());
    await docData.set(json);
  } catch (error) {
    debugPrint(error.toString());
  }
}

Future editData(
    {required int datang_sisa,
    required String id,
    required int harga,
    required int laku,
    required DateTime date,
    required String path}) async {
  try {
    debugPrint(id);
    final docData = FirebaseFirestore.instance.collection(path).doc(id);

    final data = Gas(
      datang_sisa: datang_sisa,
      harga: harga,
      laku: laku,
      date: date,
      id: id,
      total_akhir: harga * laku,
    );

    final json = data.toJson();

    await docData.set(json);
  } catch (error) {
    debugPrint(error.toString());
  }
}

Stream<List<Gas>> readData({required String path, String? first, String? end}) {
  debugPrint('Read Custom Data');

  DateTime? firstDate;
  DateTime? lastDate;

  if (first != null && end != null) {
    final DateTime dateFirst = DateTime.parse(first);
    final DateTime dateEnd = DateTime.parse(end);
    firstDate = DateTime(dateFirst.year, dateFirst.month, dateFirst.day);
    lastDate = DateTime(dateEnd.year, dateEnd.month, dateEnd.day);
  }

  return FirebaseFirestore.instance
      .collection(path)
      .where('date', isGreaterThanOrEqualTo: firstDate)
      .where('date', isLessThanOrEqualTo: lastDate)
      .orderBy('date')
      .snapshots()
      .map((snapshot) {
    return snapshot.docs.map((doc) => Gas.fromJson(doc.data())).toList();
  });
}

Stream<List<Gas>> readDataDays({required String path}) {
  debugPrint('Read Days Data');
  final now = DateTime.now();

  final startOfToday = DateTime(now.year, now.month, now.day);
  //final startOfTomorrow = startOfToday.add(const Duration(days: 1));

  try {
    final data = FirebaseFirestore.instance
        .collection(path)
        .where('date', isEqualTo: startOfToday)
        .snapshots()
        .map((event) => event.docs.map((e) => Gas.fromJson(e.data())).toList());

    return data;
  } catch (error) {
    debugPrint('Error retrieving data: $error');
    return Stream.value(List<Gas>.empty());
  }
}

Stream<List<Gas>> readDataWeekdays({required String path}) {
  debugPrint('Read Weeks Data');
  // ambil waktu hari ini
  final today = DateTime.now();
  final now = DateTime(today.year, today.month, today.day);
  // ambil hasil dari berapa waktu dari hari ini ke minggu kemaren lalu di substract(kurangi) dengan waktu sekarang
  // mis : hari ini 14 now.weekdays = 2 hari melewati hari minggu lalu substract dari hari ini 14 - 2 maka hari minggu = 12
  // jadi 1 minggu tgl 12 - 18
  final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  final endOfWeek =
      startOfWeek.add(const Duration(days: 6)); // hari Minggu dari minggu ini

  try {
    final data = FirebaseFirestore.instance
        .collection(path)
        .where('date', isGreaterThanOrEqualTo: startOfWeek)
        .where('date', isLessThanOrEqualTo: endOfWeek)
        .snapshots()
        .map((event) => event.docs.map((e) => Gas.fromJson(e.data())).toList());

    return data;
  } catch (error) {
    debugPrint('Error retrieving data: $error');
    return Stream.value(List<Gas>.empty());
  }
}

Stream<List<Gas>> readDataMonth({required String path}) {
  debugPrint('Read Month Data');
  final now = DateTime.now();

  /// Ambil Tahun dan Bulan sekarang tapi di tanggal 1
  /// lalu ambil tahun sekarang bulan sekarang + 1 di tanggal pertama lalu substract(kurangi) dengan durasi 1 hari
  /// dimana jika bulan juni tgl 1 maka hasilnya bulan mei tgl 31
  final startOfMonth = DateTime(now.year, now.month, 1);
  final endOfMonth =
      DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));

  try {
    final data = FirebaseFirestore.instance
        .collection(path)
        .where('date', isGreaterThanOrEqualTo: startOfMonth)
        .where('date', isLessThanOrEqualTo: endOfMonth)
        .snapshots()
        .map((event) => event.docs.map((e) => Gas.fromJson(e.data())).toList());

    return data;
  } catch (error) {
    debugPrint('Error retrieving data: $error');
    return Stream.value(List<Gas>.empty());
  }
}

Future deleteData({required String id, required String path}) async {
  final docUser = FirebaseFirestore.instance.collection(path).doc(id);
  await docUser.delete();
}
