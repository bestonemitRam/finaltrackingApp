import 'package:bmitserp/data/source/network/model/notification/NotificationResponse.dart';
import 'package:bmitserp/widget/buttonborder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final NotificationData items;
  NotificationCard({required this.items});
  static String dateTime(String time) {
    print("fdgdhfgi ${time}");
    DateTime dt = DateTime.parse(time);
    print("converted gmt date >> " + dt.toString());
    final localTime = dt.toLocal();
    print("local modified date >> " + localTime.toString());

    var inputDate = DateTime.parse(localTime.toString());
    var outputFormat = DateFormat('dd-MM-yyyy hh:mm a').format(inputDate);

    return outputFormat;
  }

  @override
  Widget build(BuildContext context) {
    var isread = items.readStatus == 0 ? false : true;
    return Card(
      shape: ButtonBorder(),
      elevation: 0,
      color: isread ? Colors.white12 : const Color.fromARGB(255, 107, 106, 106),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      softWrap: true,
                      items.notificationTitle,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      overflow: TextOverflow.fade,
                      softWrap: true,
                      dateTime(items.createdAt),
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
