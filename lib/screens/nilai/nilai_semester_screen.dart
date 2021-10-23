import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:parentdesk_uai/models/nilai.dart';
import 'package:parentdesk_uai/services/api.dart';
import 'package:parentdesk_uai/utils/helper.dart';
import 'package:parentdesk_uai/widgets/widget.dart';

class NilaiSemesterScreen extends StatefulWidget {
  const NilaiSemesterScreen({Key? key}) : super(key: key);

  @override
  _NilaiSemesterScreenState createState() => _NilaiSemesterScreenState();
}

class _NilaiSemesterScreenState extends State<NilaiSemesterScreen> {

  late Future<List<Nilai>> _futureListNilai;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureListNilai = getNilaiSemester().catchError((e) => alert(e.toString(), context));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Nilai>>(
      future: _futureListNilai,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          int i = 0;
          return GroupedListView<Nilai, String>(
            elements: snapshot.data!,
            groupBy: (element) => '${element.tahunSemester} ${element.semester == "1" ? "Ganjil" : "Genap"}',
            itemBuilder: (context, element) {
              i++;
              return nilaiWrapper(element.namaMK, element.kodeMK, element.nilaiHuruf, i);
            },
            groupSeparatorBuilder: (String value) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
