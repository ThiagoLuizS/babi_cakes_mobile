import 'package:flutter/material.dart';

class MessageComponent extends StatelessWidget {

  final String? message;

  const MessageComponent({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(message == null ? 'Nenhum produto para ser mostrado': message!),
      ),
    );
  }
}
