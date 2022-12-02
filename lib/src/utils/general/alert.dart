import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

alert(context, msg) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: const Text(""),
              content: Text(msg),
              actions: <Widget>[
                FloatingActionButton(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ));
      });
}

alertToast(context, msg, timeDuration, Color color, bool isSucess) {
  final snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    duration: timeDuration == 0 ? const Duration(days: 1) : Duration(seconds: timeDuration),
    behavior: SnackBarBehavior.fixed,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: isSucess ? 'Parabéns' : 'Atenção!',
      message: msg,
      contentType: isSucess ? ContentType.success : ContentType.failure,
    ),
  );
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

snackBar(context) {
  final snackBar = SnackBar(
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.fixed,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'On Snap!',
      message:
      'This is an example error message that will be shown in the body of snackbar!',
      contentType: ContentType.failure,
    ),
  );
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
