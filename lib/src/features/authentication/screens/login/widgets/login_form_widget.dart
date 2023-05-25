import 'package:babi_cakes_mobile/src/features/authentication/controllers/login/login_bloc.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/login/login_form.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/login/token_dto.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/components/shimmer_component.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/dashboard.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
import '../../../controllers/login/login_event.dart';
import '../../../controllers/login/login_state.dart';
import '../../../models/login/login_form_biometric.dart';

import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  final _formKey = GlobalKey<FormState>();

  late final LoginBloc loginBloc;
  late final LoginForm sign;

  late bool obscureText = true;

  late final LocalAuthentication auth;

  bool _checkBio = false;

  @override
  void dispose() {
    loginBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    loginBloc = LoginBloc();
    sign = LoginForm();
    auth = LocalAuthentication();

    obscureText = true;

    _checkBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
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
            } else if(state.tokenDTO.token.isEmpty && state.error.isEmpty) {
              _getLoginFormBiometric();
            } else if(state.error.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                alertToast(context, state.error, 3, Colors.grey, false);
              });
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return 'Insira o e-mail válido';
                    }
                    return null;
                  },
                  controller: emailController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_outlined),
                      labelText: tEmail,
                      hintText: tEmail,
                      border: OutlineInputBorder()),
                ),
                const SizedBox(height: tFormHeight - 20),
                TextFormField(
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return 'Insira uma senha válida';
                    }
                    return null;
                  },
                  obscureText: obscureText,
                  controller: passwordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.fingerprint),
                    labelText: tPassword,
                    hintText: tPassword,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Icon(
                            obscureText ? Icons.remove_red_eye : Icons.password)),
                  ),
                ),
                const SizedBox(height: tFormHeight - 20),

                /**
                 * TODO: Implementar recuperação de senhas
                 * */
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: TextButton(
                //     onPressed: () {
                //       ForgetPasswordScreen.buildShowModalBottomSheet(context);
                //     },
                //     child: const Text(tForgetPassword),
                //   ),
                // ),
                // -- LOGIN BTN

                SizedBox(
                  width: double.infinity,
                  child: StreamBuilder<Object>(
                    stream: loginBloc.stream,
                    builder: (context, snapshot) {
                      return ShimmerComponent(
                        isLoading: state.isLoading,
                        child: ElevatedButton(
                          onPressed: () {
                            if(!state.isLoading) {
                              _onChangeSign();
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(tLogin.toUpperCase()),
                              const Icon(Icons.fingerprint)
                            ],),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  _getLoginFormBiometric() async {
    LoginFormBiometric? loginFormBiometric = await LoginFormBiometric.get();
    TokenDTO tokenDTO = await TokenDTO.get();
    if(tokenDTO.token.isEmpty && loginFormBiometric != null) {
      _startAuth();
    }
  }

  _onChangeSign() {
    if (emailController.text != "" && emailController.text != "") {
      _onClickLogin();
    } else {
      _startAuth();
    }
  }

  _onClickLogin() async {
    loginBloc.add(LoadLoginEvent(email: emailController.text, password: passwordController.text));
  }

  _checkBiometrics() async {
    try {
      final bio = await auth.canCheckBiometrics;
      setState(() => _checkBio = bio);
      print('Biometrics = $_checkBio');
    } catch (e) {}
  }

  _startAuth() async {

    LoginFormBiometric? loginForm = await LoginFormBiometric.get();
    TokenDTO tokenDTO = await TokenDTO.get();

    if (loginForm != null && loginForm.email != null) {

      try {
        bool isAuthenticated = false;

        if(tokenDTO.token.isEmpty) {
          isAuthenticated = await auth.authenticate(
            localizedReason: 'Por favor, faça a autenticação pela sua biometria.',
            authMessages: const <AuthMessages> [
              AndroidAuthMessages(
                signInTitle: 'Coloque sua digital para entrar!',
                cancelButton: 'Cancelar',
              ),
              IOSAuthMessages(
                cancelButton: 'Cancelar',
              ),
            ],
            options: const AuthenticationOptions(
              useErrorDialogs: true,
              stickyAuth: true,
              biometricOnly: true,
            ),
          );
        }

        if(isAuthenticated) {
          loginBloc.add(LoadLoginEvent(email: loginForm.email!, password: loginForm.password!));
        }

      } on PlatformException catch (e) {
        print(e.message);
      }
    } else if(loginForm == null || loginForm!.email == null) {
      if(!mounted) return null;
      alertToast(context, "Faça o login com usuário e senha uma vez para desbloquear o login por biometria", 3, Colors.grey, false);
    }

  }
}
