import 'package:flutter/material.dart';

class SingleStatWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 150,
      padding: EdgeInsets.all(3),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(10),
        color: Colors.purple,
        child: Center(
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: -30,
                child: Center(
                  child: Icon(
                    Icons.group_outlined,
                    size: 90,
                    color: Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
              Positioned(
                top: 25,
                right: 20,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '522',
                        style: Theme.of(context).textTheme.headline5!.merge(
                              TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                      ),
                      Text(
                        'Members',
                        style: Theme.of(context).textTheme.bodyText1!.merge(
                              TextStyle(
                                color: Colors.white,
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
