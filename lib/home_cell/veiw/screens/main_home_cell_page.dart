import 'package:church_app/home_cell/controller/home_cell_controller.dart';
import 'package:church_app/home_cell/veiw/screens/cells_tab.dart';
import 'package:church_app/home_cell/veiw/widgets/home_cells_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainHomeCellPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeCellController>(
      create: (context) => HomeCellController(),
      builder: (context, _) => Scaffold(
        backgroundColor: Colors.teal[50],
        body: Row(
          children: [
            Expanded(flex: 1, child: HomeCellList()),
            Expanded(flex: 2, child: CellDetailsTap())
          ],
        ),
      ),
    );
  }
}
