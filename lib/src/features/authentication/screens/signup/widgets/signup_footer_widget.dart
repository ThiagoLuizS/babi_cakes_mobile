import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:babi_cakes_mobile/src/features/authentication/screens/components/sign_in_button_google.dart';
import '../../../../../constants/text_strings.dart';
import '../../login/login_screen.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("OR"),
        const SignInButtonGoogle(),
        TextButton(
          onPressed: () => Get.offAll(() => const LoginScreen()),
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: tAlreadyHaveAnAccount,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            TextSpan(text: tLogin.toUpperCase())
          ])),
        )
      ],
    );
  }
}
