import 'package:babi_cakes_mobile/src/features/authentication/models/dto/token_dto.dart';
import 'package:babi_cakes_mobile/src/features/authentication/screens/login/login_screen.dart';
import 'package:babi_cakes_mobile/src/utils/general/nav.dart';
import 'package:flutter/material.dart';

class ProfileCardComponent extends StatefulWidget {
  final VoidCallback onTap;
  final Icon icon;
  final String title;
  final String subTitle;
  final bool isDialog;
  const ProfileCardComponent({Key? key, required this.onTap, required this.icon, required this.title, required this.subTitle, required this.isDialog}) : super(key: key);

  @override
  State<ProfileCardComponent> createState() => _ProfileCardComponentState();
}

class _ProfileCardComponentState extends State<ProfileCardComponent> {
  @override
  Widget build(BuildContext context) {
    return !widget.isDialog ? GestureDetector(
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              widget.icon,
              Text(widget.title),
              Text(widget.subTitle),
            ],
          ),
        ),
      ),
    ) : TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
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
      ), child: Container(
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
    ),);
  }

  _exist() {
    TokenDTO.clear();
    push(context, const LoginScreen(), replace: true);
  }
}
