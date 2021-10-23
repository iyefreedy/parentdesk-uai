import 'package:flutter/material.dart';
import 'package:parentdesk_uai/screens/nilai/nilai_aktif_screen.dart';
import 'package:parentdesk_uai/screens/nilai/nilai_semester_screen.dart';
import 'package:parentdesk_uai/screens/nilai/nilai_transkrip_screen.dart';

class NilaiScreen extends StatefulWidget {
  const NilaiScreen({Key? key}) : super(key: key);

  @override
  _NilaiScreenState createState() => _NilaiScreenState();
}

class _NilaiScreenState extends State<NilaiScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Daftar Nilai',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold
            ),
          ),
          backgroundColor: Colors.blue[900],
          elevation: 0.0,
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Aktif',
              ),
              Tab(
                text: 'Semester',
              ),
              Tab(
                text: 'Keseluruhan',
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            NilaiAktifScreen(),
            NilaiSemesterScreen(),
            NilaiTranskripScreen()
          ],
        ),
      ),
    );
  }
}
