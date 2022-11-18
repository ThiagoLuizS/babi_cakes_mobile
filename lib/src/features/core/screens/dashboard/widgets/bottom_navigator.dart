import 'package:babi_cakes_mobile/src/features/core/screens/components/bottom_navigator_component.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_icons.dart';
import 'package:flutter/material.dart';

class BottomNavigator extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;

  const BottomNavigator(
      {Key? key, required this.onTap, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigatorComponent(
      onTap: onTap,
      currentIndex: currentIndex,
      items: const [
        BottomNavigatorItemComponent(
          label: 'Início',
          activeIcon: AppIcons.homeActive,
          icon: AppIcons.home,
        ),
        BottomNavigatorItemComponent(
            label: 'Busca',
            activeIcon: AppIcons.searchActive,
            icon: AppIcons.search),
        BottomNavigatorItemComponent(
          label: 'Pedidos',
          activeIcon: AppIcons.ordersActive,
          icon: AppIcons.orders,
        ),
        BottomNavigatorItemComponent(
          label: 'Perfil',
          activeIcon: AppIcons.profileActive,
          icon: AppIcons.profile,
        ),
      ],
    );
  }
}