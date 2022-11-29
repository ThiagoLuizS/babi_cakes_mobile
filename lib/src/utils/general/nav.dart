import 'package:flutter/material.dart';

Future push(BuildContext context, Widget page, {bool replace = false}) {

  Future.delayed(Duration.zero, () async {
    if(replace){
      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => page));
    }
    return Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => page));
  });

  return Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => page));
}