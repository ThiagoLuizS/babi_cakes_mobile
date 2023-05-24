import 'package:babi_cakes_mobile/src/features/authentication/models/login/token_dto.dart';

abstract class LoginState {
  TokenDTO tokenDTO = TokenDTO();
  late bool isLoading = true;
  late String error;
  late bool isSignGoogleAuthentication = false;
  LoginState({required this.tokenDTO, required this.isLoading, required this.error, required this.isSignGoogleAuthentication});
}

class LoginInitialState extends LoginState {
  LoginInitialState({required TokenDTO tokenDTO, required bool isLoading, required String error, required bool isSignGoogleAuthentication}) : super(tokenDTO: tokenDTO, isLoading: isLoading, error: error, isSignGoogleAuthentication: isSignGoogleAuthentication);
}

class LoginSuccessViewState extends LoginState {
  LoginSuccessViewState({required TokenDTO tokenDTO, required bool isLoading, required String error, required bool isSignGoogleAuthentication}) : super(tokenDTO: tokenDTO, isLoading: isLoading, error: error, isSignGoogleAuthentication: isSignGoogleAuthentication);
}

class LoginErrorState extends LoginState {
  LoginErrorState({required TokenDTO tokenDTO, required bool isLoading, required String error, required bool isSignGoogleAuthentication}) : super(tokenDTO: tokenDTO, isLoading: isLoading, error: error, isSignGoogleAuthentication: isSignGoogleAuthentication);
}

