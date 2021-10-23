import 'package:flutter/material.dart';
import 'package:parentdesk_uai/utils/helper.dart';

class RowData extends StatelessWidget {

  final String label;
  final String value;

  const RowData({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        right: 20.0,
        left: 20.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10.0
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12.0
            ),
          )
        ],
      ),
    );
  }
}

AppBar titleAppBar(String title) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15.0,
        fontWeight: FontWeight.bold
      ),
    ),
    backgroundColor: Colors.blue[900],
  );
}

Container nilaiWrapper(String mataKuliah, String kodeMK, String nilai, int index) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 12.0,
      vertical: 4.0
    ),
    color: isEven(index) ? Colors.yellowAccent : Colors.greenAccent,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mataKuliah,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
              Text(kodeMK)
            ],
          ),
        ),
        CircleAvatar(
          child: Text(
            nilai,
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
            ),
          ),
        )
      ],
    ),
  );
}
