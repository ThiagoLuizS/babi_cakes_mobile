import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/dto/token_dto.dart';
import 'package:babi_cakes_mobile/src/features/core/controllers/event/event_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/app_bar_default_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/liquid_refresh_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/shimmer_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/address/profile_address_screen.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/component/profile_card_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/cupom/profile_cupom_screen.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/notification/profile_notification_screen.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<TokenDTO> future = TokenDTO.get();
  late String name = '';
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
    future = TokenDTO.get();
    future.then((TokenDTO token) => {
          setState(() {
            name = token.name;
          })
        });
    _countByDeviceUserAndVisualizedIsFalse();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
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
                height: height,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const CircleAvatar(
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
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ProfileCardComponent(
                            onTap: () {},
                            icon: const Icon(Icons.chat_outlined),
                            title: 'Chats',
                            subTitle: 'Minhas conversas',
                            isDialog: false, notification: false,
                          ),
                          ShimmerComponent(
                            isLoading: isLoading,
                            child: ProfileCardComponent(
                              onTap: () => Get.offAll(() => const ProfileNotificationScreen()),
                              icon: const Icon(Icons.notification_add_outlined),
                              title: 'Notificações',
                              subTitle: 'Minha central de notificações',
                              isDialog: false, notification: true, quantityNotification: countEvent,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ProfileCardComponent(
                            onTap: () => Get.offAll(() => const ProfileAddressScreen()),
                            icon: Icon(Icons.location_on_outlined),
                            title: 'Endereço',
                            subTitle: 'Meus endereços de entrega',
                            isDialog: false, notification: false,
                          ),
                          ProfileCardComponent(
                            onTap: () => Get.offAll(() => const ProfileCupomScreen()),
                            icon: Icon(Icons.notification_add_outlined),
                            title: 'Cupons',
                            subTitle: 'Meus cupons de desconto',
                            isDialog: false, notification: false,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ProfileCardComponent(
                            onTap: () {},
                            icon: Icon(Icons.location_on_outlined),
                            title: 'Meus dados',
                            subTitle: 'Minhas informações da conta',
                            isDialog: false, notification: false,
                          ),
                          ProfileCardComponent(
                            onTap: () {},
                            icon: Icon(Icons.exit_to_app),
                            title: 'Sair',
                            subTitle: 'Sair do Babi Cakes',
                            isDialog: true, notification: false,
                          ),
                        ],
                      ),
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
}
