import 'dart:async';
import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';

import 'package:babi_cakes_mobile/src/features/authentication/models/login/login_form.dart';
import 'package:babi_cakes_mobile/src/features/authentication/models/login/token_dto.dart';
import 'package:babi_cakes_mobile/src/models/dto/error_view.dart';
import 'package:babi_cakes_mobile/src/service/device_service.dart';
import 'package:http/http.dart' as http;

import 'package:babi_cakes_mobile/config.dart';
import 'package:babi_cakes_mobile/src/utils/general/api_response.dart';

import 'package:babi_cakes_mobile/src/utils/general/constants.dart';

import '../../models/login/login_form_biometric.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginController {

  static Future<ApiResponse<TokenDTO>> login(String email, String password) async {
    try {
      Uri uri = Uri.http(Config.apiURL, '/api/auth');

      Map<String, String> headers = {"Content-Type": "application/json"};

      Map params = {'email': email, 'password': password};

      String encode = json.encode(params);

      var response = await http.post(uri, body: encode, headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> mapResponse = json.decode(response.body);

        final loginForm = LoginForm(email: email, password: password);
        final loginFormBiometric = LoginFormBiometric(email: email, password: password);

        loginForm.save();
        loginFormBiometric.save();

        final user = TokenDTO.fromJson(mapResponse);

        user.save();

        DeviceService.saveDeviceGetInstance();

        return ApiResponse.ok(user);
      } else {
        Map<String, dynamic> mapResponse = json.decode(response.body);
        ErrorView error = ErrorView.fromJson(mapResponse);
        return ApiResponse.errors(error.messages);
      }
    } on TimeoutException catch (e) {
      return ApiResponse.errors([msgTimeOutGlobal]);
    } on SocketException catch (e) {
      return ApiResponse.errors([msgNotConnectionGlobal]);
    } catch (e) {
      return ApiResponse.errors([msgGlobalError]);
    }
  }

  static Future<ApiResponse<User>> signGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      FirebaseAuth auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      print("Google User: ${googleUser!.email}");

      final AuthCredential credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      UserCredential result = await auth.signInWithCredential(credential);

      final firebaseUser = result.user;

      print("Firebase Name: ${firebaseUser!.displayName}");
      print("Firebase Email: ${firebaseUser!.email}");
      print("Firebase Photo: ${firebaseUser!.photoURL}");


      return ApiResponse.ok(firebaseUser);
    } catch(error) {
      return ApiResponse.errors(["Não foi possivel fazer o login pelo Google"]);
    }
  }

  static void logoutGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.signOut();
    await googleSignIn.signOut();
  }
}