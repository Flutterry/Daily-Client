import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sizer/sizer.dart';
import 'package:daily_client/src/application.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // translation system initialization
  await EasyLocalization.ensureInitialized();
  // firebase initialization
  await Firebase.initializeApp();

  Provider.debugCheckInvalidValueType = null;

  // prevent screen from rotation
  preventLandScapeMode();

  // enter full screen mode
  hideStatusBar();

  // init pref service
  final prefService = PrefService.getInstance();
  //it's called only one time in main.dart
  await prefService.init();

  //init dio services
  DioService.getInstance()
    // initInterceptors is required before using DioService
    // must be called only one time in main function
    // it required to
    // - convert form-data body to sending files to server
    // - print headers, form-data, query param, http method, endpoint and (response or error)
    ..initInterceptors()
    // if it false print lines from initInterceptors will disabled
    ..debugMode = true
    // it's option that will be send automatically with all requests you will send
    ..options = BaseOptions(
      baseUrl:
          baseApi, //now you will send request only by pass endpoint (no need to full API link)
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.acceptLanguageHeader: prefService.getAcceptLanguage(),
        HttpHeaders.authorizationHeader:
            'Bearer ${prefService.getClient()?.token}',
      },
    )
    // this function will be called if any error happened while request
    ..onRegularError = onAnyError
    // this function will be called only if the request error code is 401 unAuthenticated
    ..onUnauthenticated = onUnAuthError;

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          // public navigation key: you can access context from anywhere by using [`ContextService`]
          navigatorKey: ContextService.navigatorKey,
          // initiate BotToast Package: you can show notification, Toast, simple messages from anywhere
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          // localization sync if you use [updateLocalization('en')] from anywhere this line will trigger
          // if you need to make this application only use `en` file use locale: Locale('en')
          locale: context.locale,
          // application theming strategy just [`setIsDarkTheme(true|false)`] from prefService
          // and it will change application theme
          theme: ThemeService.getInstance().theme,
          // starting point of application
          // if you need to change it you must pass screen and provider 👇
          home: ChangeNotifierProvider(
            create: (_) => SplashProvider(),
            child: SplashScreen(),
          ),
        );
      },
    );
  }
}
