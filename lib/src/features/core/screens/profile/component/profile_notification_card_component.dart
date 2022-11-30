import 'package:babi_cakes_mobile/src/features/core/models/event/event_view.dart';
import 'package:babi_cakes_mobile/src/features/core/models/profile/address_view.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileNotificationCardComponent extends StatefulWidget {
  final EventView eventView;
  final Function onTapUpdate;

  const ProfileNotificationCardComponent({Key? key, required this.eventView, required this.onTapUpdate})
      : super(key: key);

  @override
  State<ProfileNotificationCardComponent> createState() =>
      _ProfileNotificationCardComponentState();
}

class _ProfileNotificationCardComponentState
    extends State<ProfileNotificationCardComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: GestureDetector(
        onTap: () {
          Future<void> future = showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: CustomScrollView(slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(widget.eventView.message),
                            ],
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              );
            },
          );
          future.then((value) => widget.onTapUpdate());
        },
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            border: Border.all(width: 0, color: Colors.white),
            boxShadow: const [
              BoxShadow(
                color: Color(0x32989191),
                offset: Offset(0.3, 0.3),
                blurRadius: 1.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.notifications_active_outlined),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          widget.eventView.title,
                          style: const TextStyle(
                              color: Color.fromARGB(175, 0, 0, 0), fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          widget.eventView.message,
                          style: const TextStyle(
                              color: Color.fromARGB(175, 0, 0, 0), fontSize: 13, overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                'Enviado em ${DateFormat.yMMMMd().add_jm().format(widget.eventView.dateSend)}',
                                style: const TextStyle(
                                    color: Color.fromARGB(175, 0, 0, 0), fontSize: 13, overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
