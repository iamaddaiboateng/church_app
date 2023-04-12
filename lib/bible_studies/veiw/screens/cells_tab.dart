import 'package:church_app/bible_studies/veiw/widgets/cell_meeting/bible_study_meeting_report.dart';
import 'package:church_app/bible_studies/veiw/widgets/display_bible_study_members.dart';
import 'package:flutter/material.dart';

class BibleStudyTap extends StatefulWidget {
  @override
  _BibleStudyTapState createState() => _BibleStudyTapState();
}

class _BibleStudyTapState extends State<BibleStudyTap>
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
              BibleStudyMembers(),
              BibleStudyMeetingsReport(),
            ],
          ),
        )
      ]),
    );
  }
}
