import 'package:church_app/database/controller/database_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterDatabase extends StatefulWidget {
  final String filter;
  FilterDatabase(this.filter);
  @override
  _FilterDatabaseState createState() => _FilterDatabaseState();
}

class _FilterDatabaseState extends State<FilterDatabase> {
  List filteredList = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseController>(
      builder: (_, data, __) => Scaffold(
        appBar: AppBar(
          title: Text('Find Members'),
        ),
        body: Center(
          child: Container(
            width: 400,
            child: Column(
              children: [
                TextField(
                  onChanged: (String value) {
                    setState(() {
                      filteredList = data.filterDatabase(value, widget.filter);
                    });
                  },
                  decoration: InputDecoration(hintText: widget.filter),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title:
                            Text(filteredList[index]['First Name'].toString()),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
