import 'package:babi_cakes_mobile/src/features/authentication/controllers/user/user_bloc.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/user/user_form.dart';
import 'package:babi_cakes_mobile/src/features/authentication/screens/login/login_screen.dart';
import 'package:babi_cakes_mobile/src/features/core/models/user/user_view.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:babi_cakes_mobile/src/utils/general/format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              validator: (String? value) {
                if (value != null && value.isEmpty) {
                  return 'Informe seu nome';
                }
                return null;
              },
              decoration: const InputDecoration(
                  label: Text(tFullName),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (String? value) {
                if (value != null && value.isEmpty) {
                  return 'Informe um email válido';
                }
                return null;
              },
              decoration: const InputDecoration(
                  label: Text(tEmail), prefixIcon: Icon(Icons.email_outlined)),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: _birthdayController,
              inputFormatters: [maskDate()],
              keyboardType: TextInputType.number,
              validator: (String? value) {
                if (value != null && value.isEmpty) {
                  return 'Informe sua data de aniversário';
                }
                return null;
              },
              decoration: InputDecoration(
                label: const Text(tBirdhDate),
                prefixIcon: const Icon(Icons.calendar_month),
                suffixIcon: IconButton(
                  onPressed: () {
                    selectDateBirthday(context);
                  },
                  icon:
                  const Icon(Icons.calendar_month),
                ),
              ),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              inputFormatters: [maskPhone()],
              validator: (String? value) {
                if (value != null && value.isEmpty) {
                  return 'Informe um telefone válido';
                }
                return null;
              },
              decoration: const InputDecoration(
                  label: Text(tPhoneNo), prefixIcon: Icon(Icons.numbers)),
            ),
            const SizedBox(height: tFormHeight - 20),
            TextFormField(
              controller: _passwordController,
              obscureText: obscureText,
              validator: (String? value) {
                if (value != null && value.isEmpty) {
                  return 'Informe uma senha de no mínimo 6 e máximo 8 digitos';
                }
                return null;
              },
              decoration: InputDecoration(
                label: const Text(tPassword),
                prefixIcon: const Icon(Icons.fingerprint),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon:
                      Icon(obscureText ? Icons.remove_red_eye : Icons.password),
                ),
              ),
            ),
            const SizedBox(height: tFormHeight - 10),
            !isLoading ?
                 SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _saveUser();
                        }
                      },
                      child: Text(tSignup.toUpperCase()),
                    ),
                  )
                : const Center(
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child:
                          CircularProgressIndicator(color: AppColors.berimbau),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  _saveUser() async {
    setState(() {
      isLoading = true;
    });

    late UserForm userForm = UserForm(
        _nameController.text,
        _emailController.text,
        _birthdayController.text,
        _phoneController.text,
        _passwordController.text);

    ApiResponse<Object> response = await _blocUser.saveUser(userForm);

    if (response.ok) {
      Get.offAll(
        () => const LoginScreen(
          showMessage: true,
          message:
              "Parabéns seu cadastro foi concluido. Já pode entrar em sua conta!",
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      alertToast(
          context, response.erros[0].toString(), 3, AppColors.milkCream, false);
    }
  }

  void selectDateBirthday(BuildContext context) {
    Future<DateTime?> selectDate = showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1930),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light(),
            child: child!,
          );
        });

    selectDate.then((value) => {
      setState(() {
        _birthdayController.text = DateFormat('dd/MM/yyyy').format(value!);})
    });
  }
}
