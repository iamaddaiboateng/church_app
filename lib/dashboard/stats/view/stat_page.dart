import 'package:church_app/dashboard/stats/widget/single_stat_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      padding: EdgeInsets.all(5.0),
      child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return SingleStatWidget();
          }),
    );
  }
}
