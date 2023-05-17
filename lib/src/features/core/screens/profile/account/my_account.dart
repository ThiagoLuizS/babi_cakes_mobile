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
        body: SingleChildScrollView(
          child: Container(
            padding: tPageWithTopIconPadding,
            child: Column(
              children: [
                /// <- Back arrow button
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(onTap: () => Get.offAll(() => const ProfileScreen()),child: const Icon(Icons.keyboard_backspace))
                  ),
                ),
                const FormHeaderWidget(
                  image: tSplashImage,
                  title: tMyAccountTitle,
                  subTitle: tMyAccountSubTitle,
                  imageHeight: 0.15,
                ),
                const MyAccountForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
