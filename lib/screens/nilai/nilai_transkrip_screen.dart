import 'package:flutter/material.dart';
import 'package:parentdesk_uai/models/nilai.dart';
import 'package:parentdesk_uai/services/api.dart';
import 'package:parentdesk_uai/utils/helper.dart';
import 'package:parentdesk_uai/widgets/widget.dart';

class NilaiTranskripScreen extends StatefulWidget {
  const NilaiTranskripScreen({Key? key}) : super(key: key);

  @override
  _NilaiTranskripScreenState createState() => _NilaiTranskripScreenState();
}

class _NilaiTranskripScreenState extends State<NilaiTranskripScreen> {

  late Future<List<Nilai>> _futureListNilai;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureListNilai = getNilaiTranskrip()..catchError((e) => alert(e.toString(), context));;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Nilai>>(
      future: _futureListNilai,
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
