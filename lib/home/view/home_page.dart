import 'package:church_app/bible_studies/veiw/screens/main_home_cell_page.dart';
import 'package:church_app/dashboard/view/dashboard_page.dart';
import 'package:church_app/database/view/screens/database_main/main_database.dart';
import 'package:church_app/department/veiw/screens/main_department_page.dart';
import 'package:church_app/finance/finance_main/finance_main_page.dart';
import 'package:church_app/home_cell/veiw/screens/main_home_cell_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 1;

  List<Widget> pages = [
    Dashboard(),
    DatabasePage(),
    FinanceMainPage(),
    MainHomeCellPage(),
    BibleStudyMainPage(),
    DepartmentMainPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            elevation: 10.0,
            extended: false,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_filled),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.group_outlined),
                selectedIcon: Icon(Icons.group),
                label: Text('Membership'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.money),
                selectedIcon: Icon(Icons.money_rounded),
                label: Text('Finance'),
              ),
              NavigationRailDestination(
                icon: Icon(FontAwesomeIcons.houseUser),
                selectedIcon: Icon(FontAwesomeIcons.houseUser),
                label: Text('Home Cell'),
              ),
              NavigationRailDestination(
                icon: Icon(FontAwesomeIcons.bible),
                selectedIcon: Icon(FontAwesomeIcons.bible),
                label: Text('Bible Study'),
              ),
              NavigationRailDestination(
                icon: Icon(FontAwesomeIcons.planeDeparture),
                selectedIcon: Icon(FontAwesomeIcons.planeDeparture),
                label: Text('Department'),
              ),
            ],
            selectedIndex: index,
            onDestinationSelected: (position) {
              setState(() {
                index = position;
              });
            },
          ),
          Expanded(child: pages[index])
        ],
      ),
    );
  }
}
