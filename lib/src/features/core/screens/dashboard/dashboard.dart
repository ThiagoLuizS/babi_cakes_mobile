import 'package:babi_cakes_mobile/src/features/core/screens/budget/budget_list_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/content_tab_bar_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/widgets/bottom_navigator.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_icons.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        // appBar: AppBar(
        //   title: Text(
        //     'Rua Flores do Campo, Bariri - São Paulo',
        //     style: AppTypography.localTextStyle(context),
        //   ),
        //   backgroundColor: Colors.white,
        // ),
        body: SafeArea(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            color: AppColors.milkCream,
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.homeActive),
                label: 'Início',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.searchActive),
                label: 'Busca',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.ordersActive),
                label: 'Pedidos',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(AppIcons.profileActive),
                label: 'Perfil',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.berimbau,
            onTap: (index) {
              setState(
                () {
                  _selectedIndex = index;
                },
              );
            },
          ),
        ),
      ),
    );
  }

  final List<Widget> _widgetOptions = <Widget>[
    ContentTabBarComponent(),
    const Text(
      'Pesquisar',
      style: optionStyle,
    ),
    const BudgetListView(),
    const Text(
      'Perfil',
      style: optionStyle,
    ),
  ];
}

