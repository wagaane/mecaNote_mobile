import 'package:flutter/material.dart';
import 'package:meca_note_mobile/widgets/border_radius_widget.dart';

import '../../widgets/go_back_widget.dart';
import '../../widgets/title_widget.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List _notifications = [
    {
      "contenue": "Salam garage Darou salam est disponible",
      "date": "25 juin"
    },
    {
      "contenue": "Salam garage Darou salam est disponible",
      "date": "25 juin"
    },
    {
      "contenue": "Salam garage Darou salam est disponible",
      "date": "25 juin"
    },
    {
      "contenue": "Salam garage Darou salam est disponible",
      "date": "25 juin"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        title: TitleWidget.setTitle("Mes notifications"),
        leading: MyButtonWidget.goBack(context),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0,left: 20, right: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.separated(itemBuilder: (context, index) {
            var notification = _notifications[index];
            return Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadiusWidget.borderRadius10()),
              child: ListTile(
                leading: MyButtonWidget.paddingIcon(const Icon(Icons.notifications_active)),
                title: Text("${notification['contenue']}"),
                // trailing: const Icon(Icons.arrow_forward_ios),
              ),
            );
          },
              separatorBuilder: (context, index) {
            return const SizedBox(height: 2,);
          },
          itemCount: _notifications.length),
        ),
      ),
    );
  }
}
