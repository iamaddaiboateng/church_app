import 'package:church_app/bible_studies/veiw/screens/cells_tab.dart';
import 'package:church_app/bible_studies/veiw/widgets/home_cells_list.dart';
import 'package:church_app/home_cell/controller/home_cell_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BibleStudyMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeCellController>(
      create: (context) => HomeCellController(),
      builder: (context, _) => Scaffold(
        backgroundColor: Colors.teal[50],
        body: Row(
          children: [
            Expanded(flex: 1, child: BibleStudiesList()),
            Expanded(flex: 2, child: BibleStudyTap())
          ],
        ),
      ),
    );
  }
}
