import 'package:church_app/department/veiw/widgets/cell_meeting/department_meeting_report.dart';
import 'package:church_app/department/veiw/widgets/display_department_members.dart';
import 'package:flutter/material.dart';

class DepartmentTap extends StatefulWidget {
  @override
  _DepartmentTapState createState() => _DepartmentTapState();
}

class _DepartmentTapState extends State<DepartmentTap>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          controller: tabController,
          labelColor: Colors.teal,
          tabs: [
            Tab(
              text: 'Members',
            ),
            Tab(
              text: 'Meetings',
            )
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              DepartmentMembers(),
              DepartmentMeetingsReport(),
            ],
          ),
        )
      ]),
    );
  }
}
