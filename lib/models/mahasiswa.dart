class Mahasiswa {
  String foto;
  String nama;
  String nim;
  String fakultas;
  String prodi;
  String pembimbing;
  String jalurMasuk;
  String statusAkademik;
  String alamat;
  String kota;
  String kodePos;
  String telepon;
  String nohp;
  String email;

  Mahasiswa({
    required this.foto,
    required this.nama,
    required this.nim,
    required this.fakultas,
    required this.prodi,
    required this.pembimbing,
    required this.jalurMasuk,
    required this.statusAkademik,
    required this.alamat,
    required this.kota,
    required this.kodePos,
    required this.telepon,
    required this.nohp,
    required this.email
  });

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      foto: json["url_foto"] ?? "-",
      nama: json["mhs_nm"] ?? "-",
      nim: json["mhs_nim"] ?? "-",
      fakultas: json["NamaFakultas"] ?? "-",
      prodi: json["NamaProgdi"] ?? "-",
      pembimbing: json["DosenPembimbing"] ?? "-",
      jalurMasuk: json["NamaJalurMasuk"] ?? "-",
      statusAkademik: json["NamaStatusAkademik"] ?? "-",
      alamat: json["mhs_alm"] ?? "-",
      kota: json["mhs_kota"] ?? "-",
      kodePos: json["kodepos"] ?? "-",
      telepon: json["mhs_telepon"] ?? "-",
      nohp: json["mhs_nohp"] ?? json["mhs_hp"] ?? "-",
      email: json["mhs_email"] ?? "-"
    );
  }
}