import 'package:champ/functions/func.dart';
import 'package:champ/models/notificationmodel.dart';
import 'package:champ/models/sneakermodel.dart';
import 'package:champ/presentation/colors/mycolors.dart';
import 'package:champ/presentation/textstyle.dart';
import 'package:champ/presentation/widgets/notificationitem.dart';
import 'package:champ/presentation/widgets/sneakeritem.dart';
import 'package:champ/riverpod/notificationsprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    final refresh = ref.watch(notificationsProvider);

    if (refresh) {
      Future.delayed(Duration(seconds: 4), () {
        ref.read(notificationsProvider.notifier).state = false;
        setState(() {});
      });
    }
    return Scaffold(
        backgroundColor: MyColors.background,
        appBar: AppBar(
          centerTitle: true,
          forceMaterialTransparency: true,
          title: Text('Уведомления',
              textAlign: TextAlign.start,
              style: myTextStyle(16, MyColors.text, null)),
          leading: Container(
            margin: const EdgeInsets.all(6),
            child: IconButton(
              onPressed: () {
                ZoomDrawer.of(context)!.toggle();
              },
              icon: SvgPicture.asset('assets/Hamburger.svg'),
            ),
          ),
        ),
        body: FutureBuilder(
            future: Func().getNotifications(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No notifications found.'));
              } else {
                List<NotificationModel> notifications = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return VisibilityDetector(
                      onVisibilityChanged: (info) {
                        if (info.visibleFraction > 0.7 &&
                            notifications[index].readed == false) {
                          Func().startReadTimer(notifications[index], ref);
                        }
                      },
                      key: Key(notifications[index].id.toString()),
                      child: NotificationItem(
                        readed: notifications[index].readed,
                        header: notifications[index].header,
                        body: notifications[index].body,
                        created_at: DateTime.now(),
                      ),
                    );
                  },
                );
              }
            }));
  }
}
