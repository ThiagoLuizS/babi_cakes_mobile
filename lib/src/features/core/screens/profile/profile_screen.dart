import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/dto/token_dto.dart';
import 'package:babi_cakes_mobile/src/features/authentication/screens/login/login_screen.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/app_bar_default_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/component/profile_card_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/address/profile_address_screen.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/cupom/profile_cupom_screen.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_icons.dart';
import 'package:babi_cakes_mobile/src/utils/general/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<TokenDTO> future = TokenDTO.get();
  late String name = '';

  @override
  void initState() {
    super.initState();
    future = TokenDTO.get();
    future.then((TokenDTO token) => {
          setState(() {
            name = token.name;
          })
        });
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
      body: CustomScrollView(
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
                            Text(name ?? '')
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
                          icon: Icon(Icons.chat_outlined),
                          title: 'Chats',
                          subTitle: 'Minhas conversas',
                          isDialog: false,
                        ),
                        ProfileCardComponent(
                          onTap: () {},
                          icon: const Icon(Icons.notification_add_outlined),
                          title: 'Notificações',
                          subTitle: 'Minha central de notificações',
                          isDialog: false,
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
                          onTap: () => push(context, const ProfileAddressScreen(), replace: true),
                          icon: Icon(Icons.location_on_outlined),
                          title: 'Endereço',
                          subTitle: 'Meus endereços de entrega',
                          isDialog: false,
                        ),
                        ProfileCardComponent(
                          onTap: () => push(context, const ProfileCupomScreen(), replace: true),
                          icon: Icon(Icons.notification_add_outlined),
                          title: 'Cupons',
                          subTitle: 'Meus cupons de desconto',
                          isDialog: false,
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
                          isDialog: false,
                        ),
                        ProfileCardComponent(
                          onTap: () {},
                          icon: Icon(Icons.exit_to_app),
                          title: 'Sair',
                          subTitle: 'Sair do Babi Cakes',
                          isDialog: true,
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
    );
  }
}
