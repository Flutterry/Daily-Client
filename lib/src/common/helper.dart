import 'package:bot_toast/bot_toast.dart';
import 'package:daily_client/src/application.dart';
import 'package:easy_localization/easy_localization.dart';

/// this function will trigger when any API request is fail
/// it will trigger also when error is [401: unAuth]
void onAnyError(String? title, String? body, Exception e) {
  BotToast.showSimpleNotification(
    title: title ?? tr('common.regularErrorTitle'),
    subTitle: body ?? '',
    duration: const Duration(seconds: 3),
  );
}

/// this function will trigger when and only when API request error is [401: unAuth]
Future<void> onUnAuthError() async {
  // delete all cached data to prevent any conflict can happen
  await PrefService.getInstance().clear();
  pushClear(SplashScreen(), SplashProvider());
}

/// it will open dialog to request client to login
/// if he accept he will goto login screen
/// else dialog will close and return false
Future<bool> checkAuthorization() async {
  final loginButton = ElevatedButton(
    onPressed: () async {
      pop();
      await push(LoginScreen(), LoginProvider());
    },
    child: const CustomText(tag: 'common.loginDialog.login'),
  );

  final backButton = ElevatedButton(
    onPressed: () => pop(),
    child: const CustomText(tag: 'common.loginDialog.back'),
  );

  final alertDialog = AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.emoji_emotions, size: 50, color: amber),
        SizedBox(height: 4),
        CustomText(tag: 'common.loginDialog.sorry', fontSize: 15, color: amber),
        SizedBox(height: 8),
        CustomText(tag: 'common.loginDialog.mustLoginFirst'),
      ],
    ),
    actions: [
      loginButton,
      backButton,
    ],
  );
  // this mean there is no authorized used data in local storage
  if (PrefService.getInstance().getClient() == null) {
    await showDialog(
      context: ContextService.context,
      barrierDismissible: false,
      builder: (_) => alertDialog,
    );
    return false;
  } else {
    return true;
  }
}
