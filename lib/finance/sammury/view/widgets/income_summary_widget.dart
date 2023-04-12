import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IncomeSummaryWidget extends StatelessWidget {
  final Color color;
  final String amount, type;
  IncomeSummaryWidget({this.color, this.amount, this.type});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              children: [
                Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.2),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Icon(
                        FontAwesomeIcons.moneyBill,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      type,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    Text(
                      'GHS $amount',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
