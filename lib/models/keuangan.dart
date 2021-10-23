class Keuangan {
  String tahunAjaran;
  String semester;
  String jumlahBiaya;
  String jumlahPotongan;
  String jumlahBayar;
  String kurangLebih;

  Keuangan({
    required this.tahunAjaran,
    required this.semester,
    required this.jumlahBiaya,
    required this.jumlahPotongan,
    required this.jumlahBayar,
    required this.kurangLebih
  });

  factory Keuangan.fromJson(Map<String, dynamic> json) {
    return Keuangan(
      tahunAjaran: json["tahun_ajaran"],
      semester: json["semester"],
      jumlahBiaya: json["jumlah_biaya"],
      jumlahPotongan: json["jumlah_potongan"],
      jumlahBayar: json["jumlah_bayar"],
      kurangLebih: json["kurang_lebih_bayar"]
    );
  }
}