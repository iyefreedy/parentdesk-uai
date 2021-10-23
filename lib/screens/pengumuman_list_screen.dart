import 'package:flutter/material.dart';
import 'package:parentdesk_uai/models/pengumuman.dart';
import 'package:parentdesk_uai/screens/pengumuman_screen.dart';
import 'package:parentdesk_uai/services/api.dart';
import 'package:parentdesk_uai/utils/helper.dart';
import 'package:parentdesk_uai/widgets/widget.dart';

class PengumumanListScreen extends StatefulWidget {
  const PengumumanListScreen({Key? key}) : super(key: key);

  @override
  _PengumumanListScreenState createState() => _PengumumanListScreenState();
}

class _PengumumanListScreenState extends State<PengumumanListScreen> {

  late Future<List<Pengumuman>> _futureListPengumuman;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureListPengumuman = getListPengumuman().catchError((e) => alert(e.toString(), context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppBar('Pengumuman'),
      body: SafeArea(
        child: FutureBuilder<List<Pengumuman>>(
          future: _futureListPengumuman,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              snapshot.data!.sort((a, b) => DateTime.parse(b.tanggal).compareTo(DateTime.parse(a.tanggal)));
              return Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10, right: 10, top: 20),
                  child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.black26,
                      ),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data!.isEmpty ? 0 : snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Navigator.push(context, new MaterialPageRoute(
                                  builder: (__) => new PengumumanScreen(
                                      id: snapshot.data![index].id
                                  )
                                )
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.amber,
                                      child: Text(
                                        snapshot.data![index].pengirim[0].toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    )
                                ),
                                Expanded(
                                    flex: 7,
                                    child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data![index].judul,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Poppins",
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data![index].tanggal,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Poppins",
                                                fontSize: 10.0,
                                              ),
                                            )
                                          ],
                                        )
                                    )
                                )
                              ],
                            )
                        );
                      }
                  )
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        )
      )
    );
  }
}
