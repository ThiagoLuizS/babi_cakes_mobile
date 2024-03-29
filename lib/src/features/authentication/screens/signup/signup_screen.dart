import 'package:babi_cakes_mobile/src/features/core/models/user/user_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/constants/text_strings.dart';
import 'package:babi_cakes_mobile/src/constants/variables.dart';
import 'package:babi_cakes_mobile/src/features/authentication/screens/signup/widgets/signup_footer_widget.dart';
import 'package:babi_cakes_mobile/src/features/authentication/screens/signup/widgets/signup_form_widget.dart';
import '../../../../common_widgets/form/form_header_widget.dart';
import '../welcome/welcome_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
                Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(onTap: () => Get.offAll(() => const WelcomeScreen()),child: const Icon(Icons.keyboard_backspace))
                ),
                const FormHeaderWidget(
                  image: tSplashImage,
                  title: tSignUpTitle,
                  subTitle: tSignUpSubTitle,
                  imageHeight: 0.15,
                ),
                const SignUpFormWidget(),
                const SignUpFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
