import 'package:flutter/material.dart';

class SingleIncomeHistoryWidget extends StatelessWidget {
  final String amount, incomeStream, dateReceived, dataAdded;

  SingleIncomeHistoryWidget({
    @required this.amount,
    @required this.incomeStream,
    @required this.dateReceived,
    @required this.dataAdded,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        elevation: 1,
        child: ListTile(
          title: Text(incomeStream),
          subtitle: Text('$dateReceived'),
          trailing: Material(
            borderRadius: BorderRadius.circular(10),
            color: Colors.teal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'GHS $amount',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
