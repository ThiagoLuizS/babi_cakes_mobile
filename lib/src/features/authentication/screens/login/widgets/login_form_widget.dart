import 'package:babi_cakes_mobile/src/features/authentication/controllers/login/login_bloc.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/login/token_dto.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:babi_cakes_mobile/src/utils/general/nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/dashboard.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
import '../../forget_password/forget_password_options/forget_password_model_bottom_sheet.dart';

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
  final _bloc = LoginBloc();

  late bool obscureText = true;
  late bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    obscureText = true;
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
        child: Column(
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
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  ForgetPasswordScreen.buildShowModalBottomSheet(context);
                },
                child: const Text(tForgetPassword),
              ),
            ),
            // -- LOGIN BTN
            SizedBox(
              width: double.infinity,
              child: StreamBuilder<Object>(
                stream: _bloc.stream,
                builder: (context, snapshot) {
                  return !isLoading
                      ? ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _onClickLogin();
                            }
                          },
                          child: Text(tLogin.toUpperCase()),
                        )
                      : const SizedBox(
                          height: 25,
                          child: Center(
                            child: SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                  color: AppColors.berimbau),
                            ),
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onClickLogin() async {
    setState(() {
      isLoading = true;
    });

    String email = emailController.text;
    String password = passwordController.text;

    ApiResponse<TokenDTO> response = await _bloc.login(email, password);

    if (response.ok) {
      Future.delayed(Duration.zero, () async {
        Get.offAll(() => const Dashboard());
      });
    } else {
      setState(() {
        isLoading = false;
      });
      alertToast(context, response.erros[0].toString(), 3, Colors.grey, false);
    }
  }
}
