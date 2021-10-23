import 'package:flutter/material.dart';
import 'package:parentdesk_uai/models/jadwal.dart';
import 'package:parentdesk_uai/services/api.dart';
import 'package:parentdesk_uai/utils/helper.dart';
import 'package:parentdesk_uai/widgets/widget.dart';

class JadwalUjianScreen extends StatefulWidget {
  const JadwalUjianScreen({Key? key}) : super(key: key);

  @override
  _JadwalUjianScreenState createState() => _JadwalUjianScreenState();
}

class _JadwalUjianScreenState extends State<JadwalUjianScreen> {

  late Future<List<Jadwal>> _futureListJadwal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureListJadwal = getJadwalUjian()..catchError((e) => alert(e.toString(), context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppBar('Jadwal Ujian'),
      body: SafeArea(
        child: FutureBuilder<List<Jadwal>>(
          future: _futureListJadwal,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 8.0
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.yellow
                        ),
                        child: Text(
                          snapshot.data![index].waktu,
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                snapshot.data![index].mataKuliah
                            ),
                            Text(
                                snapshot.data![index].kelas
                            ),
                            Text(
                                snapshot.data![index].dosen
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                itemCount: snapshot.data!.length,
              );
            }

            return Center(child: CircularProgressIndicator());
          }
        ),
      ),
    );
  }
}
