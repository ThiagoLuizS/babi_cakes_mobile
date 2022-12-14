import 'package:babi_cakes_mobile/src/features/core/controllers/shopping_cart/shopping_cart_controller.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/budget/budget_list_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/content_tab_bar_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/shopping_cart_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/product/product_search.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/profile_screen.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  final int indexBottomNavigationBar;

  const Dashboard({Key? key, this.indexBottomNavigationBar = 0})
      : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    setState(() {
      _selectedIndex = widget.indexBottomNavigationBar;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        return Future(() => false);
      },
      child: Consumer<ShoppingCartController>(builder: (context, cart, child) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          extendBody: true,
          bottomNavigationBar: SizedBox(
            height: cart.items.isNotEmpty ? 130 : 75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                cart.items.isNotEmpty ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ShoppingCartComponent(),
                ): Container(),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Theme(data: Theme.of(context).copyWith(canvasColor: Colors.white),
                      child: BottomNavigationBar(
                        backgroundColor: Colors.white,
                        items: const <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home_outlined,
                                color: Colors.black87),
                            label: 'Início',
                          ),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.search, color: Colors.black87),
                              label: 'Busca'),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.add_business_outlined,
                                color: Colors.black87),
                            label: 'Pedidos',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.person_outline_outlined,
                                color: Colors.black87),
                            label: 'Perfil',
                          ),
                        ],
                        currentIndex: _selectedIndex,
                        selectedItemColor: Colors.black87,
                        onTap: (index) {
                          setState(
                                () {
                              _selectedIndex = index;
                            },
                          );
                        },
                      ),)
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  final List<Widget> _widgetOptions = <Widget>[
    const ContentTabBarComponent(),
    const ProductSearch(),
    const BudgetListView(),
    const ProfileScreen()
  ];
}
