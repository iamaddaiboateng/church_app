import 'package:flutter/material.dart';

class RowData extends DataTableSource {
  final info, header;
  RowData(this.info, this.header);
  @override
  DataRow getRow(int index) {
    // print(header);
    // print(info);
    return DataRow.byIndex(
      index: index,
      cells: List.generate(
        header.length,
        (newIndex) => DataCell(
          Text(
            "${info[index][header[newIndex]] ?? ''}"
                .replaceAll('[', '')
                .replaceAll(']', ''),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => info.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
