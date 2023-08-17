import 'package:flutter/material.dart';
import 'package:nightlife/helpers/decorated_container.dart';

import '../model/work_day.dart';

class DayOfWeekDisplay extends StatelessWidget {
  const DayOfWeekDisplay({
    super.key,
    required this.day,
    required this.dayName,
  });

  final WorkDay day;
  final String dayName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DecoratedContainer(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: dayName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      TextSpan(text: '(${day.typeOfMusic.join(',')})'),
                    ]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                day.hours,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}