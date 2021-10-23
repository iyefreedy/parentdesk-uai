import 'package:flutter/material.dart';
import 'package:parentdesk_uai/models/mahasiswa.dart';
import 'package:parentdesk_uai/services/api.dart';
import 'package:parentdesk_uai/utils/helper.dart';
import 'package:parentdesk_uai/widgets/widget.dart';

class BiodataScreen extends StatefulWidget {
  const BiodataScreen({Key? key}) : super(key: key);

  @override
  _BiodataScreenState createState() => _BiodataScreenState();
}

class _BiodataScreenState extends State<BiodataScreen> {

  late Future<Mahasiswa> futureMahasiswa;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureMahasiswa = getBiodata()..catchError((e) => alert(e.toString(), context));;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppBar('Biodata'),
      body: SafeArea(
        child: FutureBuilder<Mahasiswa>(
          future: futureMahasiswa,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return ListView(
                children: [
                  Stack(
                    children: [
                      Image.asset('assets/images/slide1.jpg'),
                      snapshot.data!.foto.isEmpty ?
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 60.0),
                        child: FittedBox(
                          child: Image.asset(
                            'assets/images/student_icon.png',
                            width: 120,
                            height: 120,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ) :
                      Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(snapshot.data!.foto),
                                    fit: BoxFit.fill
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RowData(
                        label: 'Nama',
                        value: snapshot.data!.nama,
                      ),
                      RowData(
                        label: 'NIM',
                        value: snapshot.data!.nim,
                      ),
                      RowData(
                        label: 'Fakultas',
                        value: snapshot.data!.fakultas,
                      ),
                      RowData(
                        label: 'Program Studi',
                        value: snapshot.data!.prodi,
                      ),
                      RowData(
                        label: 'Pembimbing Akademik',
                        value: snapshot.data!.pembimbing,
                      ),
                      RowData(
                        label: 'Jalur Masuk',
                        value: snapshot.data!.jalurMasuk,
                      ),
                      RowData(
                        label: 'Status Akademik',
                        value: snapshot.data!.statusAkademik,
                      ),
                      RowData(
                        label: 'Alamat',
                        value: snapshot.data!.alamat,
                      ),
                      RowData(
                        label: 'Kota, Kodepos',
                        value: '${snapshot.data!.kota}, ${snapshot.data!.kodePos}',
                      ),
                      RowData(
                        label: 'No Telepon',
                        value: snapshot.data!.telepon,
                      ),
                      RowData(
                          label: 'No Handphone',
                          value: snapshot.data!.nohp
                      ),
                      RowData(
                        label: 'Email',
                        value: snapshot.data!.email,
                      )
                    ],
                  )
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator()
            );
          },
        ),
      ),
    );
  }
}
