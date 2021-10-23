class Nilai {
  String namaMK;
  String kodeMK;
  String sks;
  String nilaiHuruf;
  String tahunSemester;
  String semester;

  Nilai({required this.namaMK, required this.kodeMK, required this.sks, required this.nilaiHuruf, required this.tahunSemester, required this.semester});

  factory Nilai.fromJson(Map<String, dynamic> json) {
    return Nilai(
      namaMK: json["NamaMK"] ?? json["mtkl_nm"] ?? "-",
      kodeMK: json["KodeMK"] ?? json["mtkl_kd"] ?? "-",
      sks: json["mtkl_sks"] ?? "-",
      nilaiHuruf: json["HM"] ?? "-",
      tahunSemester: json["tahun_ajaran2"] ?? "",
      semester: json["semester2"] ?? ""
    );
  }
}