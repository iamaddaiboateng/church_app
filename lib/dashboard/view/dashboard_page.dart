import 'package:church_app/dashboard/stats/view/stat_page.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Statistics',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            StatWidget(),
          ],
        ),
      ),
    );
  }
}
