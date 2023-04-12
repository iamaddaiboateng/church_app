import 'package:church_app/home_cell/veiw/widgets/cell_meeting/cell_meeting_report.dart';
import 'package:church_app/home_cell/veiw/widgets/display_cell_members.dart';
import 'package:flutter/material.dart';

class CellDetailsTap extends StatefulWidget {
  @override
  _CellDetailsTapState createState() => _CellDetailsTapState();
}

class _CellDetailsTapState extends State<CellDetailsTap>
    with SingleTickerProviderStateMixin {
  TabController tabController;

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
              CellMembers(),
              CellMeetingsReport(),
            ],
          ),
        )
      ]),
    );
  }
}
