import 'dart:io';

import 'package:babi_cakes_mobile/src/features/core/controllers/device/device_bloc.dart';
import 'package:babi_cakes_mobile/src/features/core/models/device/device_form.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class DeviceService {

  static saveDeviceGetInstance() async {
    DeviceBloc deviceBloc = DeviceBloc();
    await Firebase.initializeApp();

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();

    Future<DeviceForm> deviceForm = setPushToken(token!);

    deviceForm.then((DeviceForm form) =>  {
      deviceBloc.saveDevice(form)
    });

    Future.delayed(Duration.zero, () async {});
  }

  static Future<DeviceForm> setPushToken(String token) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? brand;
    String? model;

    if(Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      brand = androidInfo.brand;
      model = androidInfo.model;
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      brand = 'Apple';
      model = iosInfo.utsname.machine;
    }

    DeviceForm deviceForm = DeviceForm(brand, model!, token);

    return deviceForm;
  }
}