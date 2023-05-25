import 'package:babi_cakes_mobile/src/features/authentication/controllers/login/login_controller.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/login/token_dto.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../utils/general/api_response.dart';
import '../../../core/models/user/photo_google_sign.dart';
import '../../models/user/user_forma_google.dart';
import '../../service/login_service.dart';
import '../user/user_controller.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  LoginBloc() : super(LoginInitialState(tokenDTO: TokenDTO(), isLoading: false, error: '', isSignGoogleAuthentication: false)) {

    on<LoadLoginEvent>((event, emit) => eventLoad(event, emit));

    on<LoadSignGoogleEvent>((event, emit) => eventLoadSignGoogle(event, emit));

  }

  eventLoad(LoadLoginEvent event, Emitter emitter) async {
    emitter(LoginSuccessViewState(tokenDTO: TokenDTO(), isLoading: true, error: '', isSignGoogleAuthentication: false));
    ApiResponse<TokenDTO> tokenDTO = await LoginController.login(event.email, event.password);
    if(tokenDTO.ok) {

      PhotoGoogleSign photoGoogleSign = await PhotoGoogleSign.get();

      LoginService.clearPhotoSign(photoGoogleSign, event.email);

      emitter(LoginSuccessViewState(tokenDTO: tokenDTO.result, isLoading: false, error: '', isSignGoogleAuthentication: false));
    } else {
      emitter(LoginErrorState(tokenDTO: TokenDTO(), isLoading: false, error: tokenDTO.erros[0], isSignGoogleAuthentication: false));
    }
  }

  eventLoadSignGoogle(LoadSignGoogleEvent event, Emitter emitter) async {
    emitter(LoginSuccessViewState(tokenDTO: TokenDTO(), isLoading: true, error: '', isSignGoogleAuthentication: false));

    LoginController loginController = LoginController();
    ApiResponse<User> user = await loginController.signGoogle();

    if(user.ok) {
      late UserFormGoogle userForm = UserFormGoogle(user.result.displayName!, user.result.email!, user.result.uid);
      ApiResponse<Object> response = await UserController.saveUserGoogle(userForm);
      if(response.ok) {
        ApiResponse<TokenDTO> tokenDTO = await LoginController.login(userForm.email, userForm.password);
        if(tokenDTO.ok) {

          PhotoGoogleSign photoGoogleSign = await PhotoGoogleSign.get();

          LoginService.getAndSetPhotoSign(photoGoogleSign, user.result.photoURL!, userForm.email);

          emitter(LoginSuccessViewState(tokenDTO: tokenDTO.result, isLoading: false, error: '', isSignGoogleAuthentication: true));
        }
      } else {
        emitter(LoginErrorState(tokenDTO: TokenDTO(), isLoading: false, error: response.erros[0], isSignGoogleAuthentication: false));
      }
    } else {
      emitter(LoginErrorState(tokenDTO: TokenDTO(), isLoading: false, error: user.erros[0], isSignGoogleAuthentication: false));
    }
  }
}