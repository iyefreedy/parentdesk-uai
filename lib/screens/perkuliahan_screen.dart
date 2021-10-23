import 'package:flutter/material.dart';
import 'package:parentdesk_uai/models/jadwal.dart';
import 'package:parentdesk_uai/services/api.dart';
import 'package:parentdesk_uai/utils/helper.dart';
import 'package:parentdesk_uai/widgets/widget.dart';

class PerkuliahanScreen extends StatefulWidget {
  const PerkuliahanScreen({Key? key}) : super(key: key);

  @override
  _PerkuliahanScreenState createState() => _PerkuliahanScreenState();
}

class _PerkuliahanScreenState extends State<PerkuliahanScreen> {

  late Future<List<Jadwal>> _futureListJadwal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureListJadwal = getJadwalKuliah()
      .catchError((e) => alert(e.toString(), context));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppBar('Jadwal Kuliah'),
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                            snapshot.data![index].mataKuliah
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                            snapshot.data![index].kelas
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                            snapshot.data![index].dosen
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
