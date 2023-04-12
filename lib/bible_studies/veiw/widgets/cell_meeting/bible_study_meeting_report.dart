import 'package:church_app/bible_studies/controller/bible-study_controller.dart';
import 'package:church_app/core/widget/material_container.dart';
import 'package:church_app/home_cell/utils/cell_strings.dart';
import 'package:church_app/home_cell/veiw/widgets/cell_meeting/cells_meetings_column.dart';
import 'package:church_app/utils/hive_strings.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class BibleStudyMeetingsReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: MaterialContainer(
        info: 'Bible Study Meeting Report',
        child: Scaffold(
          body: ValueListenableBuilder(
            valueListenable: Hive.box(kHiveBibleStudyMeetingBox).listenable(),
            builder: (_, Box box, __) {
              List meetings = box.values
                  .where(
                    (element) =>
                        element[HomeCellString.cellName] ==
                        Provider.of<BibleStudyController>(context)
                            .bibleStudyName,
                  )
                  .toList();

              int totalMembers = 0;
              int totalMale = 0;
              int totalFemale = 0;
              int elders = 0;
              int children = 0;
              int deacon = 0;
              int deaconess = 0;
              double offering = 0.0;

              meetings.forEach((element) {
                totalMembers += element[HomeCellString.totalMembers];
                totalMale += element[HomeCellString.males];
                totalFemale += element[HomeCellString.females];
                elders += element[HomeCellString.elders];
                children += element[HomeCellString.children];
                deacon += element[HomeCellString.deacons];
                deaconess += element[HomeCellString.deaconess];
                offering += element[HomeCellString.offering];
              });

              return Center(
                child: Container(
                  height: 8000,
                  width: 700,
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 3,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.all(30),
                    children: [
                      CellMeetingColumn(
                        total: "${meetings.length}",
                        info: "Total Meetings",
                      ),
                      CellMeetingColumn(
                        total: "$totalMembers",
                        info: "Accumulated Members",
                      ),
                      CellMeetingColumn(
                        total: "$totalMale",
                        info: "Accumulated Males",
                      ),
                      CellMeetingColumn(
                        total: "$totalFemale",
                        info: "Females",
                      ),
                      CellMeetingColumn(
                        total: "$children",
                        info: "Children",
                      ),
                      CellMeetingColumn(
                        total: "$elders",
                        info: "Elders",
                      ),
                      CellMeetingColumn(
                        total: "$deacon",
                        info: "Deacons",
                      ),
                      CellMeetingColumn(
                        total: "$deaconess",
                        info: "Deaconess",
                      ),
                      CellMeetingColumn(
                        total: "$offering",
                        info: "Offering (GHS)",
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
