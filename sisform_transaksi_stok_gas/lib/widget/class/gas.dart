import 'package:cloud_firestore/cloud_firestore.dart';

class Gas {
  String id;
  int? datang_sisa;
  int? harga;
  int? laku;
  int? total_akhir;
  DateTime date;

  Gas({
    this.id = '',
    required this.datang_sisa,
    required this.harga,
    required this.laku,
    required this.date,
    this.total_akhir,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'datang/sisa': datang_sisa,
        'harga': harga,
        'laku': laku,
        'total_akhir': total_akhir,
        'date': date,
      };

  static Gas fromJson(Map json) => Gas(
      id: json['id'],
      total_akhir: json['total_akhir'],
      datang_sisa: json['datang/sisa'],
      harga: json['harga'],
      laku: json['laku'],
      date: (json['date'] as Timestamp).toDate());
}
