import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:babi_cakes_mobile/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:babi_cakes_mobile/src/features/authentication/screens/components/sign_in_button_google.dart';

import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';

class LoginFooterWidget extends StatefulWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginFooterWidget> createState() => _LoginFooterWidgetState();
}

class _LoginFooterWidgetState extends State<LoginFooterWidget> {


  @override
  void dispose() {
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OU"),
        const SizedBox(height: tFormHeight - 20),
        const SignInButtonGoogle(),
        const SizedBox(height: tFormHeight - 20),
        TextButton(
          onPressed: () => Get.to(() => const SignUpScreen()),
          child: Text.rich(
            TextSpan(
                text: tDontHaveAnAccount,
                style: Theme.of(context).textTheme.bodyText1,
                children: [
                  TextSpan(text: tSignup.toUpperCase(), style: const TextStyle(color: Colors.blue))
                ]),
          ),
        ),
      ],
    );
  }


}
