class Jadwal {
  String kelas;
  String mataKuliah;
  String waktu;
  String dosen;
  String sks;

  String berhalangan;
  String pengganti;

  Jadwal({required this.kelas, required this.mataKuliah, required this.dosen, required this.waktu, required this.sks, required this.berhalangan, required this.pengganti});

  factory Jadwal.fromJson(Map<String, dynamic> json) {
    return Jadwal(
      kelas: json["NamaKelas"] ?? json["ruang"] ?? "-",
      mataKuliah: json["NamaMK"] ?? json["mtkl_nm"] ?? "-",
      waktu: json["JadwalKuliah"] ?? "-",
      dosen: json["NamaDosen"] ?? json["ds_nm"] ?? "-",
      sks: json["sks"] ?? "-",
      berhalangan: json["tanggal_tidak_hadir"] ?? "-",
      pengganti: json["tanggal_pengganti"] ?? "-"
    );
  }
}