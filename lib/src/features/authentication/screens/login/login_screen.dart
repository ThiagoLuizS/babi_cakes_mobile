import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:babi_cakes_mobile/src/common_widgets/form/form_header_widget.dart';
import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/constants/text_strings.dart';
import '../../../../constants/variables.dart';
import 'widgets/login_footer_widget.dart';
import 'widgets/login_form_widget.dart';

class LoginScreen extends StatefulWidget {
  final bool showMessage;
  final String message;

  const LoginScreen({Key? key, this.showMessage = false, this.message = ""}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getMessageExternal();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: tPageWithTopIconPadding, //Get it from constants -> variables.dart
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(onTap: () => Get.offAll(() => const LoginScreen()), child: const Icon(Icons.keyboard_backspace))
                ),
                const FormHeaderWidget(
                  image: tWelcomeScreenImage,
                  title: tLoginTitle,
                  subTitle: tLoginSubTitle,
                ),
                const LoginFormWidget(),
                const LoginFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getMessageExternal() {
    Future.delayed(Duration.zero, () async {
      if(widget.showMessage) {
        alertToast(context, widget.message, 0, AppColors.milkCream, true);
      }
    });
  }
}
