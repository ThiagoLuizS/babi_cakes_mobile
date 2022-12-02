import 'package:babi_cakes_mobile/src/features/core/controllers/event/event_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/event/event_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/app_bar_default_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/liquid_refresh_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/shimmer_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/dashboard.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/component/profile_notification_card_component.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileNotificationScreen extends StatefulWidget {
  const ProfileNotificationScreen({Key? key}) : super(key: key);

  @override
  State<ProfileNotificationScreen> createState() => _ProfileNotificationScreenState();
}

class _ProfileNotificationScreenState extends State<ProfileNotificationScreen> {
  late List<EventView> eventViewList = [];
  final EventBloc _blocEvent = EventBloc();
  late bool isLoading = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _blocEvent.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getByUserNotVisualized();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Get.offAll(() => const Dashboard(indexBottomNavigationBar: 3));
        },
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.berimbau,
        ),
      ),
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarDefaultComponent(
          title: "Notificações",
        ),
      ),
      body: LiquidRefreshComponent(
        onRefresh: () async => _getByUserNotVisualized(),
        child: SizedBox(
          height: height,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: eventViewList.length,
                      itemBuilder: (BuildContext itemBuilder, index) {
                        EventView event = eventViewList[index];
                        return ShimmerComponent(
                          isLoading: isLoading,
                          child: ProfileNotificationCardComponent(
                            eventView: event,
                            onTapUpdate: () => _updateEventVizualized(event.id),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getByUserNotVisualized() async {
    setState(() {
      isLoading = true;
    });

    ApiResponse<List<EventView>> response =
    await _blocEvent.getByUserNotVisualized();

    if (response.ok) {
      setState(() {
        eventViewList = response.result;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  _updateEventVizualized(int eventId) async {
    ApiResponse<bool> response =
    await _blocEvent.updateEventVizualized(eventId);

    if (response.ok) {
      _getByUserNotVisualized();
    } else {
      alertToast(context, response.erros[0].toString(), 3, Colors.grey, false);
    }
  }
}
