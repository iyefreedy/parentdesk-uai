import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:parentdesk_uai/models/pengumuman.dart';
import 'package:parentdesk_uai/services/api.dart';
import 'package:parentdesk_uai/utils/helper.dart';
import 'package:parentdesk_uai/widgets/widget.dart';

class PengumumanScreen extends StatefulWidget {

  final String id;
  PengumumanScreen({Key? key, required this.id}) : super(key: key);

  @override
  _PengumumanScreenState createState() => _PengumumanScreenState();
}

class _PengumumanScreenState extends State<PengumumanScreen> {

  late Future<Pengumuman> _futurePengumuman;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futurePengumuman = getPengumuman(widget.id)
        .catchError((e) => alert(e.toString(), context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppBar('Pengumuman'),
      body: SafeArea(
        child: FutureBuilder<Pengumuman>(
          future: _futurePengumuman,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(8.0)
                ),
                margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    Text(
                      snapshot.data!.judul,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      snapshot.data!.tanggal,
                      style: TextStyle(
                        color: Colors.black45,
                        fontFamily: "Poppins",
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 12.0,),
                    Html(
                      data: snapshot.data!.isi,
                      style: {
                        "*" : Style(margin: EdgeInsets.all(0.0))
                      },
                    ),
                  ],
                ),
              );
            }

            return Center(child: CircularProgressIndicator());
          }
        )
      )
    );
  }
}
