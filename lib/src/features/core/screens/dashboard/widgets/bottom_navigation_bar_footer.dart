import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BottomNavigationFooter extends StatelessWidget {
  const BottomNavigationFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          color: AppColors.white
        ),
        child: const TabBar(
          labelColor: Colors.black87,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: AppColors.berimbau,
          tabs: [
            Tab(
              icon: Icon(Icons.home_outlined,
                  color: Colors.black87),
              text: 'Início',
            ),
            Tab(
                icon: Icon(Icons.search, color: Colors.black87),
                text: 'Busca'),
            Tab(
              icon: Icon(Icons.add_business_outlined,
                  color: Colors.black87),
              text: 'Pedidos',
            ),
            Tab(
              icon: Icon(Icons.person_outline_outlined,
                  color: Colors.black87),
              text: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
