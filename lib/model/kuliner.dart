class Kuliner {
  final String nama;
  final String tanggal;
  final String lokasi;
  final String foto;

  Kuliner(
      {required this.nama,
      required this.tanggal,
      required this.lokasi,
      required this.foto});

  Kuliner copyWith({
    String? nama,
    String? tanggal,
    String? lokasi,
    String? foto,
  }) {
    return Kuliner(
      nama: nama ?? this.nama,
      tanggal: tanggal ?? this.tanggal,
      lokasi: lokasi ?? this.lokasi,
      foto: foto ?? this.foto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nama': nama,
      'tanggal': tanggal,
      'lokasi': lokasi,
      'foto': foto,
    };
  }

  factory Kuliner.fromMap(Map<String, dynamic> map) {
    return Kuliner(
      nama: map['nama'] as String,
      tanggal: map['tanggal'] as String,
      lokasi: map['lokasi'] as String,
      foto: map['pic'] as String,
    );
  }
}
