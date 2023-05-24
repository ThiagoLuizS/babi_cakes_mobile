import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/constants/text_strings.dart';
import 'package:babi_cakes_mobile/src/features/authentication/controllers/login/login_bloc.dart';
import 'package:babi_cakes_mobile/src/features/authentication/controllers/login/login_event.dart';
import 'package:babi_cakes_mobile/src/features/authentication/controllers/login/login_state.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/dashboard.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SignInButtonGoogle extends StatefulWidget {
  const SignInButtonGoogle({Key? key}) : super(key: key);

  @override
  State<SignInButtonGoogle> createState() => _SignInButtonGoogleState();
}

class _SignInButtonGoogleState extends State<SignInButtonGoogle> {
  late final LoginBloc loginBloc;

  @override
  void dispose() {
    loginBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<LoginBloc, LoginState>(
          bloc: loginBloc,
          buildWhen: (previousState, state) {
            return true;
          },
          builder: (context, state) {

            if(state.isSignGoogleAuthentication) {
              Future.delayed(Duration.zero, () async {
                Get.offAll(() => const Dashboard());
              });
            } else if(state.error.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                alertToast(context, state.error, 3, Colors.grey, false);
              });
            }

            return OutlinedButton.icon(
              icon: const Image(image: AssetImage(tGoogleLogoImage), width: 20.0),
              onPressed: () => _handleSignInGoogle(),
              label: Text(tSignInWithGoogle.toUpperCase()),
            );
          }
      ),
    );
  }

  _handleSignInGoogle() async {
    loginBloc.add(LoadSignGoogleEvent());
  }
}
