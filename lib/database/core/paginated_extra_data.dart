import 'package:flutter/material.dart';

headerToDataTable(headerInfo) {
  return List.generate(
    headerInfo.length,
    (index) => DataColumn(
      label: Text(headerInfo[index].toString()),
    ),
  );
}
