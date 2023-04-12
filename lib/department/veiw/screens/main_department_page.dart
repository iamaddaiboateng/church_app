import 'package:church_app/bible_studies/veiw/screens/cells_tab.dart';
import 'package:church_app/department/controller/department_controller.dart';
import 'package:church_app/department/veiw/widgets/home_cells_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepartmentMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DepartmentController>(
      create: (context) => DepartmentController(),
      builder: (context, _) => Scaffold(
        backgroundColor: Colors.teal[50],
        body: Row(
          children: [
            Expanded(
              flex: 1,
              child: DepartmentList(),
            ),
            Expanded(
              flex: 2,
              child: BibleStudyTap(),
            )
          ],
        ),
      ),
    );
  }
}
