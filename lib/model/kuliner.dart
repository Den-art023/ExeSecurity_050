import 'dart:convert';

class Kuliner {
  final String nama;
  final String tanggal;
  final String lokasi;

  Kuliner({required this.nama, required this.tanggal, required this.lokasi});

  Kuliner copyWith({String? nama, String? tanggal, String? lokasi}) {
    return Kuliner(
        nama: nama ?? this.nama,
        tanggal: tanggal ?? this.tanggal,
        lokasi: lokasi ?? this.lokasi);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'nama': nama, 'date': tanggal, 'lokasi': lokasi};
  }

  factory Kuliner.fromMap(Map<String, dynamic> map) {
    return Kuliner(
        nama: map['nama'] as String,
        tanggal: map['date'] as String,
        lokasi: map['lokasi'] as String);
  }

  String toJson() => json.encode(toMap());

  factory Kuliner.fromJson(String source) =>
      Kuliner.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Kuliner(nama: $nama, date: $tanggal, lokasi: $lokasi)';
  }

  @override
  bool operator ==(covariant Kuliner other) {
    if (identical(this, other)) return true;

    return other.nama == nama &&
        other.tanggal == tanggal &&
        other.lokasi == lokasi;
  }

  @override
  int get hashCode {
    return nama.hashCode ^ tanggal.hashCode ^ lokasi.hashCode;
  }
}
