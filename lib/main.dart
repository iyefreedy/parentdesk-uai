import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parentdesk_uai/screens/biodata_screen.dart';
import 'package:parentdesk_uai/screens/jadwal_ujian_screen.dart';
import 'package:parentdesk_uai/screens/keuangan_screen.dart';
import 'package:parentdesk_uai/screens/kuliah_pengganti_screen.dart';
import 'package:parentdesk_uai/screens/login_screen.dart';
import 'package:parentdesk_uai/screens/main_screen.dart';
import 'package:parentdesk_uai/screens/nilai/nilai_screen.dart';
import 'package:parentdesk_uai/screens/pengumuman_list_screen.dart';
import 'package:parentdesk_uai/screens/perkuliahan_screen.dart';
import 'package:parentdesk_uai/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => const SplashScreen(),
        '/login' : (context) => const LoginScreen(),
        '/main' : (context) => const MainScreen(),
        '/keuangan' : (context) => const KeuanganScreeen(),
        '/biodata' : (context) => const BiodataScreen(),
        '/kuliah-pengganti' : (context) => const KuliahPenggantiScreen(),
        '/jadwal-ujian' : (context) => const JadwalUjianScreen(),
        '/nilai' : (context) => const NilaiScreen(),
        '/perkuliahan' : (context) => const PerkuliahanScreen(),
        '/pengumuman-list' : (context) => const PengumumanListScreen()
      },
      theme: ThemeData(
        fontFamily: 'Poppins'
      ),
    );
  }
}
