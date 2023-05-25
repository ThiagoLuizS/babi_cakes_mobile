import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/login/token_dto.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/event/event_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/app_bar_default_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/liquid_refresh_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/address/profile_address_screen.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/component/profile_card_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/cupom/profile_cupom_screen.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/notification/profile_notification_screen.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/user/photo_google_sign.dart';
import 'account/my_account.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<TokenDTO> future = TokenDTO.get();
  late String name = '';
  late String photo = '';
  late bool isLoading = true;
  late int countEvent = 0;
  final EventBloc _blocEvent = EventBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _blocEvent.dispose();
  }

  @override
  void initState() {
    super.initState();

    _getUserSession();
    _countByDeviceUserAndVisualizedIsFalse();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarDefaultComponent(
          title: "Perfil",
        ),
      ),
      backgroundColor: Colors.white,
      body: LiquidRefreshComponent(
        onRefresh: () => _countByDeviceUserAndVisualizedIsFalse(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          photo.isNotEmpty ? CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(photo),
                          ) : const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(tProfileImage),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Olá,",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(name)
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        ProfileCardComponent(
                          onTap: () => Get.offAll(() => const ProfileAddressScreen()),
                          icon: const Icon(Icons.location_on_outlined),
                          title: 'Endereço',
                          subTitle: 'Meus endereços de entrega',
                          isDialog: false, notification: false,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        ProfileCardComponent(
                          onTap: () => Get.offAll(() => const ProfileNotificationScreen()),
                          icon: const Icon(Icons.notification_add_outlined),
                          title: 'Notificações',
                          subTitle: 'Minha central de notificações',
                          isDialog: false, notification: true, quantityNotification: countEvent,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        ProfileCardComponent(
                          onTap: () => Get.offAll(() => const MyAccount()),
                          icon: const Icon(Icons.location_on_outlined),
                          title: 'Meus dados',
                          subTitle: 'Minhas informações da conta',
                          isDialog: false, notification: false,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ProfileCardComponent(
                          onTap: () => Get.offAll(() => const ProfileCupomScreen()),
                          icon: const Icon(Icons.notification_add_outlined),
                          title: 'Cupons',
                          subTitle: 'Meus cupons de desconto',
                          isDialog: false, notification: false,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        ProfileCardComponent(
                          onTap: () {},
                          icon: const Icon(Icons.exit_to_app),
                          title: 'Sair',
                          subTitle: 'Sair do Babi Cakes',
                          isDialog: true, notification: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _countByDeviceUserAndVisualizedIsFalse() async {
    setState(() {
      isLoading = true;
    });

    ApiResponse<int> response =
    await _blocEvent.countByDeviceUserAndVisualizedIsFalse();

    if (response.ok) {
      setState(() {
        countEvent = response.result;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  _getUserSession() async {
    TokenDTO tokenDTO = await TokenDTO.get();
    PhotoGoogleSign photoGoogleSign = await PhotoGoogleSign.get();
    if(tokenDTO!.name != null) {
      setState(() {
        name = tokenDTO.name!;
      });
    }
    if(photoGoogleSign!.photo != null) {
      setState(() {
        photo = photoGoogleSign.photo!;
      });
    }
  }
}
