import 'package:babi_cakes_mobile/src/features/authentication/controllers/login/login_bloc.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/login/login_form.dart';
import 'package:babi_cakes_mobile/src/features/authentication/screens/login/login_fingerprint.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:babi_cakes_mobile/src/common_widgets/form/form_header_widget.dart';
import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/constants/text_strings.dart';
import '../../../../constants/variables.dart';
import '../../../core/screens/dashboard/dashboard.dart';
import '../../controllers/login/login_event.dart';
import '../../controllers/login/login_state.dart';
import '../../models/login/token_dto.dart';
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

    _getMessageExternal();
    _getVerifyAuthenticationOld();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: tPageWithTopIconPadding, //Get it from constants -> variables.dart
            child: BlocBuilder<LoginBloc, LoginState>(
              bloc: loginBloc,
              buildWhen: (previousState, state) {
                return true;
              },
              builder: (context, state) {

                if(state.tokenDTO.token.isNotEmpty) {
                  Future.delayed(Duration.zero, () async {
                    Get.offAll(() => const Dashboard());
                  });
                } else if(state.error.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    alertToast(context, state.error, 3, Colors.grey, false);
                  });
                }

                return Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(onTap: () => Get.offAll(() => const LoginScreen()), child: const Icon(Icons.keyboard_backspace))
                    ),
                    const FormHeaderWidget(
                      image: tSplashImage,
                      title: tLoginTitle,
                      subTitle: tLoginSubTitle,
                    ),
                    const LoginFormWidget(),
                    const LoginFooterWidget(),
                  ],
                );
              }
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

  _getVerifyAuthenticationOld() async {
    LoginForm? loginForm = await LoginForm.get();
    if(loginForm != null && loginForm!.email != null) {
      loginBloc.add(LoadLoginEvent(email: loginForm!.email!, password: loginForm!.password!));
    }
  }

}

