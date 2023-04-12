import 'package:flutter/material.dart';

class MaterialContainer extends StatelessWidget {
  final String info;
  final Widget child;

  MaterialContainer({
    required this.child,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$info",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            Flexible(fit: FlexFit.loose, child: child)
          ],
        ),
      ),
    );
  }
}
