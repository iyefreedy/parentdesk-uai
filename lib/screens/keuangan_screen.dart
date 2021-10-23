import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:parentdesk_uai/models/keuangan.dart';
import 'package:parentdesk_uai/services/api.dart';
import 'package:parentdesk_uai/utils/helper.dart';
import 'package:parentdesk_uai/widgets/widget.dart';

class KeuanganScreeen extends StatefulWidget {
  const KeuanganScreeen({Key? key}) : super(key: key);

  @override
  _KeuanganScreeenState createState() => _KeuanganScreeenState();
}

class _KeuanganScreeenState extends State<KeuanganScreeen> {

  late Future<List<Keuangan>> futureListKeuangan;

  List<DataRow> _listData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureListKeuangan = getKeuangan().catchError((e) => alert(e.toString(), context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppBar('Keuangan'),
      body: SafeArea(
        child: FutureBuilder<List<Keuangan>>(
          future: futureListKeuangan,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              snapshot.data!.forEach((element) {
                _listData.add(
                    DataRow(
                        cells: [
                          DataCell(Text(element.tahunAjaran)),
                          DataCell(Text(element.semester)),
                          DataCell(Text(getCurrencySymbol(element.jumlahBiaya))),
                          DataCell(Text(getCurrencySymbol(element.jumlahPotongan))),
                          DataCell(Text(getCurrencySymbol(element.jumlahBayar))),
                          DataCell(Text(getCurrencySymbol(element.kurangLebih))),
                        ]
                    )
                );
              });
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      DataTable(
                        horizontalMargin: 2.0,
                        columns: [
                          DataColumn(
                              label: Text(
                                'Tahun Ajaran',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                ),
                              )
                          ),
                          DataColumn(
                            label: Text(
                              'Semester',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          DataColumn(
                              label: Text(
                                'Jumlah Biaya',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              )
                          ),
                          DataColumn(
                              label: Text(
                                'Jumlah Potongan',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              )
                          ),
                          DataColumn(
                              label: Text(
                                'Jumlah Bayar',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              )
                          ),
                          DataColumn(
                              label: Text(
                                'Kurang/Lebih Bayar',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              )
                          )
                        ],
                        rows: _listData,
                      ),
                    ]
                ),
              );
            }

            return Center(child: CircularProgressIndicator());
          }
        ),
      ),
    );
  }

  // Future<void> initData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String nim = prefs.getString("nim") ?? "";
  //   String pwd = prefs.getString("pwd") ?? "";
  //
  //   var url = BASE_URL + "keuangan/Rekap/format/json";
  //
  //   var response = await post(
  //     Uri.parse(url),
  //     body: {
  //       "token": TOKEN_BODY,
  //       "nim": nim,
  //       "pwd": pwd
  //     },
  //     headers: {
  //       'token': TOKEN_HEADER,
  //       'Authorization': 'Basic ' + BASIC_AUTH,
  //     }
  //   );
  //
  //   Map<String, dynamic> decodedMap = json.decode(response.body);
  //   String status = decodedMap["status"];
  //
  //   if(status == "TRUE") {
  //     setState(() {
  //       _dataTable = List.from(decodedMap["data"]);
  //     });
  //   }
  //
  // }
}
