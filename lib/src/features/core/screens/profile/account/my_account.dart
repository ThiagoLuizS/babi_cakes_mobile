import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/constants/variables.dart';
import 'package:babi_cakes_mobile/src/features/authentication/controllers/user/user_bloc.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/user/user_form.dart';
import 'package:babi_cakes_mobile/src/features/authentication/screens/login/login_screen.dart';
import 'package:babi_cakes_mobile/src/features/core/models/user/user_view.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/profile/profile_screen.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../common_widgets/form/form_header_widget.dart';
import '../../../../../constants/text_strings.dart';
import '../../../../authentication/screens/signup/widgets/signup_footer_widget.dart';
import '../../../../authentication/screens/welcome/welcome_screen.dart';
import '../../components/app_bar_default_component.dart';
import '../../dashboard/dashboard.dart';
import 'my_account_form.dart';

class MyAccount extends StatefulWidget {

  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final _blocUser = UserBloc();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late bool isLoading = false;
  late bool obscureText = true;

  @override
  void dispose() {
    super.dispose();
    _blocUser.dispose();
  }

  @override
  void initState() {
    super.initState();
    isLoading = false;
    obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            title: "Meus Dados",
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: tPageWithTopIconPadding,
            child: Column(
              children: const [
                FormHeaderWidget(
                  image: tSplashImage,
                  title: tMyAccountTitle,
                  subTitle: tMyAccountSubTitle,
                  imageHeight: 0.15,
                ),
                MyAccountForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
