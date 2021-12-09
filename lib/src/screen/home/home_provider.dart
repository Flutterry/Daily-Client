import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:daily_client/src/application.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeProvider extends ChangeNotifier {
  final dioService = DioService.getInstance();
  final prefService = PrefService.getInstance();

  /// used to test if there is an authorized client data saved in local storage
  Client? get client => prefService.getClient();

  /// this list contain pages that will open when client click on bottom navigation items
  /// open first page when first navigation item click
  /// open second page when second navigation item click
  /// open .... page when .... navigation item click
  /// we have 4 navigation bottom items with 4 different screens
  ///
  /// some role of screens in this list :=
  /// all this screens mustn't have a scaffold widget because drawer widget in home screen only
  /// all this screens must have a [CustomButtonNavigationSpacer()] widget at end of tree
  List<Widget> get _pages => [
        ChangeNotifierProvider(
          create: (_) => DeliboxProvider(),
          child: DeliboxScreen(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrdersProvider(),
          child: OrdersScreen(),
        ),
        ChangeNotifierProvider(
          create: (_) => StoriesProvider(),
          child: StoriesScreen(),
        ),
        ChangeNotifierProvider(
          create: (_) => AccountProvider(),
          child: AccountScreen(),
        ),
      ];

  /// this field will be index of current viewed page on home screen
  int _currentPageIndex = 0;

  /// this method will return selectedPage to view it on home screen
  /// the value based on [_pages] list and [_currentPageIndex] value
  Widget getCurrentSelectedPage() {
    return _pages[_currentPageIndex];
  }

  /// this method will update ['_currentPageIndex'] field
  /// that will change current viewed page on home screen
  /// this method will trigger if and only if ```newIndex != _currentPageIndex```
  Future<void> changeCurrentPageIndex(int newIndex) async {
    if (newIndex == _currentPageIndex) return;

    // this screen indexes can't open if there is no authorized client in local storage
    final protectedIndex = [1, 2, 3];
    if (protectedIndex.contains(newIndex)) {
      final authorized = await checkAuthorization();
      if (!authorized) {
        notifyListeners();
        return;
      }
    }

    _currentPageIndex = newIndex;
    notifyListeners();
  }

  /// this field value will be a timestamp from last time clicked on back button
  int? _lastBackClickTime;

  /// this is allowed diff time between two back clicks to close home screen
  final _durationBetweenTwoClicks = 500;

  /// this method decide if home screen will pop when user go back or not
  /// it will POPed if and only if user click back two times in [_durationBetweenTwoClicks] millisecond
  Future<bool> canPop() async {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    if (_lastBackClickTime == null ||
        currentTime - _lastBackClickTime! > _durationBetweenTwoClicks) {
      _lastBackClickTime = currentTime;

      BotToast.showText(text: tr('home.pressAgainToBack'));
      // prevent pop action
      return Future.delayed(Duration.zero, () => false);
    }
    // allow pop action
    return Future.delayed(Duration.zero, () => true);
  }

  /// logout from application will do:
  /// * clear all local storage not only client data
  /// * refresh hame screen ui
  /// * remove 'Authentication' header from dioService Headers
  Future<void> logOut() async {
    // first close drawer
    pop();
    // send logout request to server
    await dioService.post(
      logoutApi,
      showLoading: true,
      data: {'device_name': await getDeviceName()},
    );
    // clear local storage
    await prefService.clear();
    // remove authentication header from dio
    dioService.addHeader({HttpHeaders.authorizationHeader: ''});
    // refresh ui
    notifyListeners();
  }
}
