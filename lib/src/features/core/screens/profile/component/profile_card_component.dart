import 'package:babi_cakes_mobile/src/features/authentication/models/login/token_dto.dart';
import 'package:babi_cakes_mobile/src/features/authentication/screens/login/login_screen.dart';
import 'package:babi_cakes_mobile/src/features/authentication/screens/components/sign_in_button_google.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ProfileCardComponent extends StatefulWidget {
  final VoidCallback onTap;
  final Icon icon;
  final String title;
  final String subTitle;
  final bool isDialog;
  final bool notification;
  final int quantityNotification;

  const ProfileCardComponent(
      {Key? key,
      required this.onTap,
      required this.icon,
      required this.title,
      required this.subTitle,
      required this.isDialog,
      this.notification = false, this.quantityNotification = 0})
      : super(key: key);

  @override
  State<ProfileCardComponent> createState() => _ProfileCardComponentState();
}

class _ProfileCardComponentState extends State<ProfileCardComponent> {

  static const List<String> scopes = [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: scopes);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !widget.isDialog
        ? GestureDetector(
            onTap: widget.onTap,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x32989191),
                    offset: Offset(0.4, 0.4),
                    blurRadius: 1.4,
                    spreadRadius: 1.4,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    widget.notification && widget.quantityNotification > 0
                        ? Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 20,
                                  child: Center(child: Text(widget.quantityNotification.toString(), style: const TextStyle(color: Colors.white),)),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.icon,
                        Text(
                          widget.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            widget.subTitle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : TextButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Sair'),
                content: const Text('Deseja realmente sair?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Não'),
                  ),
                  TextButton(
                    onPressed: () => _exist(),
                    child: const Text('Sim'),
                  ),
                ],
              ),
            ),
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x32989191),
                    offset: Offset(0.4, 0.4),
                    blurRadius: 1.4,
                    spreadRadius: 1.4,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    widget.icon,
                    Text(widget.title),
                    Text(widget.subTitle),
                  ],
                ),
              ),
            ),
          );
  }

  _exist() {
    TokenDTO.clear();
    _handleSignOut();
    Get.offAll(() => const LoginScreen());
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();
}
