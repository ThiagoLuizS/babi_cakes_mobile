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

alertToast(context, msg, timeInSecForIosWeb, Color color) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}
