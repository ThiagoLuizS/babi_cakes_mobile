import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:babi_cakes_mobile/src/common_widgets/form/form_header_widget.dart';
import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/constants/text_strings.dart';
import '../../../../constants/variables.dart';
import 'widgets/login_footer_widget.dart';
import 'widgets/login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: tPageWithTopIconPadding, //Get it from constants -> variables.dart
            child: Column(
              children: [
                // Back arrow button
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
}
