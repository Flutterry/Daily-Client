import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:daily_client/src/application.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:location/location.dart';
import 'local_model/version.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashProvider extends ChangeNotifier {
  final prefService = PrefService.getInstance();
  final dioService = DioService.getInstance();

  SplashProvider() {
    startIntro();
    pickLocation();
    sendNotificationToken();
    searchForUpdates();
  }

  /// last known location if this user
  LocationData? get _currentLocation => prefService.getCurrentLocation();

  /// if login return true else false
  bool get _authorized => prefService.getClient() != null;

  bool _tokenChecked = false;
  bool _introChecked = false;
  bool _updatesChecked = false;
  bool _locationChecked = false;

  /// start 5 sec timer.
  Future<void> startIntro() async {
    await Future.delayed(const Duration(seconds: 5));
    _introChecked = true;
    _finish();
  }

  /// getting current location and save it in local storage
  /// if there is a location already in the local storage not do any thing
  Future<void> pickLocation() async {
    if (_currentLocation != null) {
      _locationChecked = true;
      return _finish();
    }

    LocationData? location;
    try {
      location =
          await Location().getLocation().timeout(const Duration(seconds: 5));
    } catch (_) {}
    prefService.setCurrentLocation(
      LocationData.fromMap({
        //default latitude if package fail getting current location
        'latitude': location?.latitude ?? 16.6011803,
        //default longitude if package fail getting current location
        'longitude': location?.longitude ?? 42.9347922,
      }),
    );
    _locationChecked = true;
    _finish();
  }

  /// send notification token to server if authorized
  Future<void> sendNotificationToken() async {
    if (!_authorized) {
      _tokenChecked = true;
      return _finish();
    }

    // getting last saved notification token in local storage
    final notificationToken = await getDeviceToken(FirebaseMessaging.instance);

    // if current notification token is same as last sended notification token
    // then don't do anything
    // else send the new notification token and save it in local storage
    if (prefService.getNotificationToken() != notificationToken) {
      final data = {
        'token': notificationToken,
        'device_name': await getDeviceName(),
        'lang': prefService.getAcceptLanguage(),
      };
      final result = await dioService.put(tokenApi, data: data);
      if (result.response == null) return _showErrorDialog();

      prefService.setNotificationToken(notificationToken ?? '');
    }
    _tokenChecked = true;
    _finish();
  }

  /// check if there is exists updates
  /// if so : if this update is required => open unClosed update dialog else open normal update dialog
  Future<void> searchForUpdates() async {
    final result = await dioService.get(versionApi);
    if (result.response == null) return _showErrorDialog();
    final version = Version.fromMap(result.response!.data);
    if (await version.needToUpgrade()) {
      // clearing all local storage data
      // so:  if there is prevent any conflict data between local and upcoming data in this update.
      await PrefService.getInstance().clear();
      return _showUpdateDialog(version);
    }
    _updatesChecked = true;
    _finish();
  }

  /// this method will check if all `_*Checked` fields is true
  /// then will decide witch screen to navigate
  void _finish() {
    final validation = [
      _locationChecked,
      _tokenChecked,
      _introChecked,
      _updatesChecked,
    ];

    if (validation.contains(false)) return;

    if (prefService.getIsApplicationFirstStart()) {
      pushClear(IntroductionScreen(), IntroductionProvider());
    } else {
      pushClear(HomeScreen(), HomeProvider());
    }
  }

  /// if error dialog is already open not open a new one
  bool _isDialogOpen = false;
  Future<void> _showErrorDialog() async {
    if (_isDialogOpen) return;
    _isDialogOpen = true;

    final dialogAction = ElevatedButton(
      onPressed: () {
        //close dialog
        pop();
        // retry running all failed actions
        if (!_tokenChecked) sendNotificationToken();
        if (!_updatesChecked) searchForUpdates();
      },
      child: CustomText(
        text: tr('splash.errorDialog.action'),
        color: Colors.white,
      ),
    );

    final alertDialog = AlertDialog(
      title: CustomText(
        text: tr('splash.errorDialog.title'),
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      content: CustomText(
        text: tr('splash.errorDialog.body'),
        fontSize: 12,
        maxLines: 10,
      ),
      actions: [dialogAction],
    );

    // show dialog in when dialog is closed set [`isDialogOpen`] = false
    showDialog(
      // ContextService is a class you can use to access context from anywhere in application
      context: ContextService.context,
      barrierDismissible: false,
      builder: (_) => alertDialog,
    ).then(
      (_) => _isDialogOpen = false,
    );
  }

  /// show [when and only when] version.needToUpgrade() return true
  void _showUpdateDialog(Version version) {
    final dialogAction = ElevatedButton(
      onPressed: () async {
        //open google play or app store to upgrade
        if (Platform.isIOS) {
          if (await canLaunch(appStoreLink)) {
            await launch(appStoreLink);
          } else {
            BotToast.showText(text: tr('splash.manualUpdate'));
          }
        } else {
          if (await canLaunch(googlePlayLink)) {
            await launch(googlePlayLink);
          } else if (await canLaunch(huaweiGalleryLink)) {
            await launch(huaweiGalleryLink);
          } else {
            BotToast.showText(text: tr('splash.manualUpdate'));
          }
        }
      },
      child: CustomText(
        text: tr('splash.updateDialog.action'),
        color: Colors.white,
      ),
    );

    final alertDialog = AlertDialog(
      title: CustomText(
        text: tr('splash.updateDialog.title'),
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: tr(
              'splash.updateDialog.body',
              args: [
                version.versionCode,
                version.myVersionCode!,
              ],
            ),
            fontSize: 12,
            maxLines: 10,
          ),
          SizedBox(height: version.notes.isEmpty ? 0 : 5),
          if (version.notes.isNotEmpty)
            CustomText(
              text: tr('splash.updateDialog.releaseNotes'),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          if (version.notes.isNotEmpty)
            ...version.notes
                .split('\n')
                .map(
                  (note) => CustomText(
                    text: note,
                    maxLines: 5,
                  ),
                )
                .toList(),
        ],
      ),
      actions: [dialogAction],
    );

    showDialog(
      context: ContextService.context,
      barrierDismissible: false,
      builder: (_) => alertDialog,
    );
  }
}
