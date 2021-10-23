class Pengumuman {
  String id;
  String pengirim;
  String judul;
  String tanggal;
  String isi;

  Pengumuman({required this.id, required this.pengirim, required this.judul, required this.tanggal, required this.isi});

  factory Pengumuman.fromJson(Map<String, dynamic> json) {
    return Pengumuman(
      id: json["IDNotifikasi"] ?? "",
      pengirim: json["pengirim"] ?? "",
      judul: json["JudulNotifikasi"] ?? "",
      tanggal: json["TanggalBuat"] ?? "",
      isi: json["IsiNotifikasi"] ?? ""
    );
  }
}