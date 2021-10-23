import 'package:flutter/material.dart';
import 'package:parentdesk_uai/models/jadwal.dart';
import 'package:parentdesk_uai/services/api.dart';
import 'package:parentdesk_uai/utils/helper.dart';
import 'package:parentdesk_uai/widgets/widget.dart';

class KuliahPenggantiScreen extends StatefulWidget {
  const KuliahPenggantiScreen({Key? key}) : super(key: key);

  @override
  _KuliahPenggantiScreenState createState() => _KuliahPenggantiScreenState();
}

class _KuliahPenggantiScreenState extends State<KuliahPenggantiScreen> {

  List<DataRow> _listData = [];

  late Future<List<Jadwal>> _futureListJadwal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureListJadwal = getJadwalPengganti()..catchError((e) => alert(e.toString(), context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppBar('Jadwal Pengganti'),
      body: SafeArea(
        child: FutureBuilder<List<Jadwal>>(
          future: _futureListJadwal,
          builder: (context, snapshot) {
            if(snapshot.hasData) {

              snapshot.data!.forEach((element) {
                _listData.add(
                  new DataRow(
                    cells: [
                      DataCell(Text(element.mataKuliah)),
                      DataCell(Text(element.berhalangan)),
                      DataCell(Text(element.pengganti)),
                      DataCell(Text(element.dosen)),
                      DataCell(Text(element.kelas)),
                    ]
                ));
              });
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    decoration: BoxDecoration(
                        border: Border.symmetric(horizontal: BorderSide(color: Colors.black, width: 3.0))
                    ),
                    horizontalMargin: 1.0,
                    columns: [
                      DataColumn(
                        label: Text('Mata Kuliah', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      DataColumn(
                          label: Text('Kuliah Berhalangan', style: TextStyle(fontWeight: FontWeight.bold))
                      ),
                      DataColumn(
                          label: Text('Kuliah Pengganti', style: TextStyle(fontWeight: FontWeight.bold))
                      ),
                      DataColumn(
                          label: Text('Dosen', style: TextStyle(fontWeight: FontWeight.bold))
                      ),
                      DataColumn(
                          label: Text('Ruang', style: TextStyle(fontWeight: FontWeight.bold))
                      )
                    ],
                    rows: _listData,
                  ),
                ),
              );
            }

            return Center(child: CircularProgressIndicator());
          }
        ),
      ),
    );
  }
}