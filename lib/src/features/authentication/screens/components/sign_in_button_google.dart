import 'package:babi_cakes_mobile/src/constants/image_strings.dart';
import 'package:babi_cakes_mobile/src/constants/text_strings.dart';
import 'package:babi_cakes_mobile/src/features/authentication/controllers/login/login_bloc.dart';
import 'package:babi_cakes_mobile/src/features/authentication/controllers/user/user_bloc.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/login/token_dto.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/user/user_forma_google.dart';
import 'package:babi_cakes_mobile/src/features/core/screens/dashboard/dashboard.dart';
import 'package:babi_cakes_mobile/src/features/core/theme/app_colors.dart';
import 'package:babi_cakes_mobile/src/utils/general/alert.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';

class SignInButtonGoogle extends StatefulWidget {
  const SignInButtonGoogle({Key? key}) : super(key: key);

  @override
  State<SignInButtonGoogle> createState() => _SignInButtonGoogleState();
}

class _SignInButtonGoogleState extends State<SignInButtonGoogle> {
  final _blocUser = UserBloc();
  final _loginBloc = LoginBloc();
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false;

  static const List<String> scopes = [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: scopes);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _listenGoogleSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        icon: const Image(image: AssetImage(tGoogleLogoImage), width: 20.0),
        onPressed: () => _handleSignIn(),
        label: Text(tSignInWithGoogle.toUpperCase()),
      ),
    );
  }

  _listenGoogleSignIn() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) async {
      bool isAuthorized = account != null;
      if (kIsWeb && account != null) {
        isAuthorized = await _googleSignIn.canAccessScopes(scopes);
      }

      setState(() {
        _currentUser = account;
        _isAuthorized = isAuthorized;
      });

      if (isAuthorized) {
        _handleGetContact(account!);
      }
    });

    _googleSignIn.signInSilently();
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    _findAndSaveUser(user);
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  _findAndSaveUser(GoogleSignInAccount user) async {
    late UserFormGoogle userForm = UserFormGoogle(user.displayName!, user.email, user.id);
    ApiResponse<Object> response = await _blocUser.saveUserGoogle(userForm);
    if (response.ok) {
      ApiResponse<TokenDTO> responseLogin = await _loginBloc.login(userForm.email, userForm.password);
      if(responseLogin.ok) {
        Future.delayed(Duration.zero, () async {
          Get.offAll(() => const Dashboard());
        });
      } else {
        alertToast(context, responseLogin.erros[0].toString(), 3, AppColors.milkCream, false);
      }
    } else {
      alertToast(context, response.erros[0].toString(), 3, AppColors.milkCream, false);
    }
  }
}
