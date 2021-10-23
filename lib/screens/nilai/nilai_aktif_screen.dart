import 'package:flutter/material.dart';
import 'package:parentdesk_uai/models/nilai.dart';
import 'package:parentdesk_uai/services/api.dart';
import 'package:parentdesk_uai/utils/helper.dart';
import 'package:parentdesk_uai/widgets/widget.dart';

class NilaiAktifScreen extends StatefulWidget {
  const NilaiAktifScreen({Key? key}) : super(key: key);

  @override
  State<NilaiAktifScreen> createState() => _NilaiAktifScreenState();
}

class _NilaiAktifScreenState extends State<NilaiAktifScreen> {

  late Future<List<Nilai>> futureListNilai;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureListNilai = getNilaiAktif()..catchError((e) => alert(e.toString(), context));;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Nilai>>(
      future: futureListNilai,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return ListView.separated(
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) => Divider(color: Colors.black12),
            itemBuilder: (context, index) {
              return nilaiWrapper(snapshot.data![index].namaMK, snapshot.data![index].kodeMK, snapshot.data![index].nilaiHuruf, index);
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
