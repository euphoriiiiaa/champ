import 'package:champ/functions/func.dart';
import 'package:champ/models/notificationmodel.dart';
import 'package:champ/models/sneakermodel.dart';
import 'package:champ/presentation/widgets/notificationitem.dart';
import 'package:champ/presentation/widgets/sneakeritem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff7f7f9),
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: Text(
            'Уведомления',
            textAlign: TextAlign.start,
            style: GoogleFonts.raleway(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          leading: Container(
            margin: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new_outlined),
            ),
          ),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width - 10,
          child: FutureBuilder(
              future: Func().getNotifications(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No notifications found.'));
                } else {
                  List<NotificationModel> sneakers = snapshot.data!;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.8,
                      crossAxisCount: 2,
                    ),
                    scrollDirection: Axis.vertical,
                    itemCount: sneakers.length,
                    itemBuilder: (context, index) {
                      return NotificationItem(
                        header: sneakers[index].header,
                        body: '',
                        created_at: DateTime.now(),
                      );
                    },
                  );
                }
              }),
        ));
  }
}
