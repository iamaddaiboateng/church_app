import 'package:church_app/finance/expenditure_histotry/view/screens/expenditure_main.dart';
import 'package:church_app/finance/graph/view/finance_graph_page.dart';
import 'package:church_app/finance/income_history/view/screen/main_income_history.dart';
import 'package:church_app/finance/income_stream/view/finance_income_stream.dart';
import 'package:church_app/finance/sammury/view/finance_summary.dart';
import 'package:flutter/material.dart';

class FinanceMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100].withOpacity(0.5),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: IncomeStream(),
                  ),
                  Expanded(
                    child: FinanceGraph(),
                  ),
                  Expanded(child: Center(child: IncomeSummary()))
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(child: MainIncomeHistory()),
                  Expanded(child: MainExpenditure()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
