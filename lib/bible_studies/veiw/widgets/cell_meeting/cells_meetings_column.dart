import 'package:flutter/material.dart';

class CellMeetingColumn extends StatelessWidget {
  final String total, info;
  CellMeetingColumn({this.total, this.info});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            '$total',
            style: TextStyle(
              color: Colors.black,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(),
          Text(
            info,
            style: TextStyle(
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
