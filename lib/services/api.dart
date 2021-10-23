import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:parentdesk_uai/constants.dart';
import 'package:parentdesk_uai/models/jadwal.dart';
import 'package:parentdesk_uai/models/keuangan.dart';
import 'package:parentdesk_uai/models/mahasiswa.dart';
import 'package:parentdesk_uai/models/nilai.dart';
import 'package:parentdesk_uai/models/pengumuman.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Handle logout
void logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("nim", "");
  prefs.setString("pwd", "");
  prefs.setBool("logged", false);
  Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
}

// Fetch biodata mahasiswa from API
Future<Mahasiswa> getBiodata() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String nim = prefs.getString("nim") ?? "";
  String pwd = prefs.getString("pwd") ?? "";

  var url = BASE_URL + "biodata/LihatBiodata/format/json";

  Response response;

  try {
    response = await post(
        Uri.parse(url),
        body: {
          "token": TOKEN_BODY,
          "nim": nim,
          "pwd": pwd
        },
        headers: {
          'token': TOKEN_HEADER,
          'Authorization': 'Basic ' + BASIC_AUTH,
        }
    );
  } on SocketException {
    throw SocketException('No internet connection');
  }

  Map<String, dynamic> decodedMap = json.decode(response.body);
  String status = decodedMap["status"];

  if(status == "TRUE") {
    print(decodedMap["data"]);
    return Mahasiswa.fromJson(decodedMap["data"][0]);
  } else {
    throw Exception("Failed to load data");
  }
}

// Fetch data rekap keuangan from API
Future<List<Keuangan>> getKeuangan() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String nim = prefs.getString("nim") ?? "";
  String pwd = prefs.getString("pwd") ?? "";

  var url = BASE_URL + "keuangan/Rekap/format/json";

  Response response;

  try {
    response = await post(
      Uri.parse(url),
      body: {
        "token": TOKEN_BODY,
        "nim": nim,
        "pwd": pwd
      },
      headers: {
        'token': TOKEN_HEADER,
        'Authorization': 'Basic ' + BASIC_AUTH,
      }
    );
  } on SocketException {
    throw SocketException('No internet connection');
  }

  Map<String, dynamic> decodedMap = json.decode(response.body);
  String status = decodedMap["status"];

  if(status == "TRUE") {
    print(decodedMap["data"]);
    return List.from(decodedMap["data"]).map((e) => Keuangan.fromJson(e)).toList();
  } else {
    throw Exception("Failed load data");
  }
}

// Fetch nilai aktif from API
Future<List<Nilai>> getNilaiSemester() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String nim = prefs.getString("nim") ?? "";
  String pwd = prefs.getString("pwd") ?? "";

  var url = BASE_URL + "akademik/DaftarNilaiPerSemester/format/json";

  Response response;

  try {
    response = await post(
        Uri.parse(url),
        body: {
          "token": TOKEN_BODY,
          "nim": nim,
          "pwd": pwd
        },
        headers: {
          'token': TOKEN_HEADER,
          'Authorization': 'Basic ' + BASIC_AUTH,
        }
    );
  } on SocketException {
    throw SocketException('No internet connection');
  }

  Map<String, dynamic> decodedMap = json.decode(response.body);
  String status = decodedMap["status"];

  if(status == "TRUE") {
    print(decodedMap["data"]);
    return List.from(decodedMap["data"]).map((e) => Nilai.fromJson(e)).toList();
  } else {
    throw Exception(decodedMap["pesan"]);
  }
}

// Fetch nilai semester from API
Future<List<Nilai>> getNilaiAktif() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String nim = prefs.getString("nim") ?? "";
  String pwd = prefs.getString("pwd") ?? "";

  var url = BASE_URL + "akademik/DaftarNilaiSemesterAktif/format/json";

  Response response;

  try {
    response = await post(
        Uri.parse(url),
        body: {
          "token": TOKEN_BODY,
          "nim": nim,
          "pwd": pwd
        },
        headers: {
          'token': TOKEN_HEADER,
          'Authorization': 'Basic ' + BASIC_AUTH,
        }
    );
  } on SocketException {
    throw SocketException('No internet connection');
  }

  Map<String, dynamic> decodedMap = json.decode(response.body);
  String status = decodedMap["status"];

  if(status == "TRUE") {
    print(decodedMap["data"]);
    return List.from(decodedMap["data"]).map((e) => Nilai.fromJson(e)).toList();
  } else {
    throw Exception(decodedMap["pesan"]);
  }
}

// Fetch nilai transkrip from API
Future<List<Nilai>> getNilaiTranskrip() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String nim = prefs.getString("nim") ?? "";
  String pwd = prefs.getString("pwd") ?? "";

  var url = BASE_URL + "akademik/DaftarNilaiKeseluruhan/format/json";
  Response response;

  try {
    response = await post(
        Uri.parse(url),
        body: {
          "token": TOKEN_BODY,
          "nim": nim,
          "pwd": pwd
        },
        headers: {
          'token': TOKEN_HEADER,
          'Authorization': 'Basic ' + BASIC_AUTH,
        }
    );
  } on SocketException {
    throw SocketException('No internet connection');
  }

  Map<String, dynamic> decodedMap = json.decode(response.body);
  String status = decodedMap["status"];

  if(status == "TRUE") {
    print(decodedMap["data"]);
    return List.from(decodedMap["data"]).map((e) => Nilai.fromJson(e)).toList();
  } else {
    throw Exception(decodedMap["pesan"]);
  }
}

// Fetch pengumuman list from API
Future<List<Pengumuman>> getListPengumuman() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String nim = prefs.getString("nim") ?? "";
  String pwd = prefs.getString("pwd") ?? "";

  var url = BASE_URL + "notifikasi/getPengumumanByNIM/format/json";

  Response response;

  try {
    response = await post(
        Uri.parse(url),
        body: {
          "token": TOKEN_BODY,
          "nim": nim,
          "pwd": pwd
        },
        headers: {
          'token': TOKEN_HEADER,
          'Authorization': 'Basic ' + BASIC_AUTH,
        }
    );
  } on SocketException {
    throw SocketException('No internet connection');
  }

  Map<String, dynamic> decodedMap = json.decode(response.body);
  String status = decodedMap["status"];

  if(status == "TRUE") {
    return List.from(decodedMap["data"]).map((e) => Pengumuman.fromJson(e)).toList();
  } else {
    throw Exception(decodedMap["pesan"]);
  }
}

Future<List<Jadwal>> getJadwalKuliah() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String nim = prefs.getString("nim") ?? "";
  String pwd = prefs.getString("pwd") ?? "";
  var url = BASE_URL + "jadwal/JadwalKuliah/format/json";

  Response response;

  try {
    response = await post(
        Uri.parse(url),
        body: {
          "token": TOKEN_BODY,
          "nim": nim,
          "pwd": pwd
        },
        headers: {
          'token': TOKEN_HEADER,
          'Authorization': 'Basic ' + BASIC_AUTH,
        }
    );
  } on SocketException {
    throw SocketException('No internet connection');
  }

  Map<String, dynamic> decodedMap = json.decode(response.body);

  String status = decodedMap["status"];
  if(status == "TRUE") {
    print(decodedMap["data"]);
    return List.from(decodedMap["data"]).map((e) => Jadwal.fromJson(e)).toList();
  } else {
    throw Exception(decodedMap["pesan"]);
  }
}

Future<List<Jadwal>> getJadwalUjian() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String nim = prefs.getString("nim") ?? "";
  String pwd = prefs.getString("pwd") ?? "";
  var url = BASE_URL + "jadwal/JadwalUjian/format/json";

  Response response;

  try {
    response = await post(
        Uri.parse(url),
        body: {
          "token": TOKEN_BODY,
          "nim": nim,
          "pwd": pwd
        },
        headers: {
          'token': TOKEN_HEADER,
          'Authorization': 'Basic ' + BASIC_AUTH,
        }
    );
  } on SocketException {
    throw SocketException('No internet connection');
  }

  Map<String, dynamic> decodedMap = json.decode(response.body);

  String status = decodedMap["status"];
  if(status == "TRUE") {
    print(decodedMap["data"]);
    return List.from(decodedMap["data"]).map((e) => Jadwal.fromJson(e)).toList();
  } else {
    throw Exception(decodedMap["pesan"]);
  }
}

Future<List<Jadwal>> getJadwalPengganti() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String nim = prefs.getString("nim") ?? "";
  String pwd = prefs.getString("pwd") ?? "";
  var url = BASE_URL + "jadwal/JadwalKuliahPengganti/format/json";

  Response response;

  try {
    response = await post(
        Uri.parse(url),
        body: {
          "token": TOKEN_BODY,
          "nim": nim,
          "pwd": pwd
        },
        headers: {
          'token': TOKEN_HEADER,
          'Authorization': 'Basic ' + BASIC_AUTH,
        }
    );
  } on SocketException {
    throw SocketException('No internet connection');
  }

  Map<String, dynamic> decodedMap = json.decode(response.body);

  String status = decodedMap["status"];
  if(status == "TRUE") {
    print(decodedMap["data"]);
    return List.from(decodedMap["data"]).map((e) => Jadwal.fromJson(e)).toList();
  } else {
    throw Exception(decodedMap["pesan"]);
  }
}

Future<Pengumuman> getPengumuman(String id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String nim = prefs.getString("nim") ?? "";
  String pwd = prefs.getString("pwd") ?? "";
  var url = BASE_URL + "notifikasi/getDetailPengumuman/format/json";

  Response response;

  try {
    response = await post(
        Uri.parse(url),
        body: {
          "token": TOKEN_BODY,
          "nim": nim,
          "pwd": pwd,
          "idpengumuman": id
        },
        headers: {
          'token': TOKEN_HEADER,
          'Authorization': 'Basic ' + BASIC_AUTH,
        }
    );
  } on SocketException {
    throw SocketException('No internet connection');
  }

  Map<String, dynamic> decodedMap = json.decode(response.body);
  String status = decodedMap["status"];

  if(status == "TRUE") {
    print(decodedMap["data"]);
    return Pengumuman.fromJson(decodedMap["data"][0]);
  } else {
    throw Exception(decodedMap["pesan"]);
  }
}