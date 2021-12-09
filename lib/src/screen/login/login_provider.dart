import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:daily_client/src/application.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginProvider extends ChangeNotifier {
  final dioService = DioService.getInstance();
  final prefService = PrefService.getInstance();

  /// be sure this key is linked to login form
  final formKey = GlobalKey<FormState>();

  /// be sure this controller linked to PinPut
  final pinController = TextEditingController();

  /// this field control how many digits in confirmation sms message
  final pinDigitLength = 6;

  /// phone code country ex. +966
  /// linked to phone Text editing
  Code code = Code();

  /// linked to phone text editing
  final phoneController = TextEditingController();

  /// this field will be true before sending sms confirmation pin code
  bool canWritePhoneNumber = true;

  /// validate form
  /// send phone number to get confirmation sms
  Future<void> requestPinCode() async {
    if (formKey.currentState!.validate() == false) return;

    final data = {
      'phone': code.dialCode.replaceFirst('+', '00') + phoneController.text,
    };
    final result = await dioService.post(
      pinApi,
      data: data,
      showLoading: true,
      handleAuth: false,
    );
    if (result.response == null) return;

    // mean sms was sended to client phone, so he can't write phone number again
    // he must fill code pin digits
    canWritePhoneNumber = false;
    notifyListeners();
  }

  /// validate if client fill all [`pinDigitLength`] digits in PinPut fields
  /// send login request
  /// if request successful then save user data in local storage and close login page
  /// else return without do any thing
  Future<void> login() async {
    if (pinController.text.length < pinDigitLength) {
      BotToast.showText(text: tr('login.pinCode.pleaseEnterPinCode'));
      return;
    }
    final data = {
      'token': await getDeviceToken(FirebaseMessaging.instance),
      'device_name': await getDeviceName(),
      'phone': code.dialCode.replaceFirst('+', '00') + phoneController.text,
      'verification_code': pinController.text,
    };
    final result = await dioService.post(
      loginApi,
      data: data,
      showLoading: true,
      handleAuth: false,
    );
    if (result.response == null) return;

    final client = Client.fromMap(result.response!.data);
    await Future.wait([
      prefService.setClient(client),
      prefService.setNotificationToken(client.token),
    ]);

    dioService.addHeader(
      {HttpHeaders.authorizationHeader: 'Bearer ${client.token}'},
    );
    notifyListeners();
    pop();
  }
}
