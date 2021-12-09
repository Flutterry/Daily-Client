import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/introduction/local_model/intro_page.dart';

class IntroductionProvider extends ChangeNotifier {
  final dioService = DioService.getInstance();
  final prefService = PrefService.getInstance();

  IntroductionProvider() {
    loadIntroductionDetails();
  }

  /// be sure this controller is linked with introduction screen's `PageView`
  final introductionPageController = PageController();

  /// this field will contain all intro pages after [`loadIntroductionDetails`] method is called without any error
  final introPages = <IntroPage>[];

  /// called on `initState`
  /// if there is any error then go to home screen
  Future<void> loadIntroductionDetails() async {
    final result = await dioService.get(introductionApi, showLoading: true);
    // error happen
    if (result.response == null) pushClear(HomeScreen(), HomeProvider());
    for (final object in result.response!.data) {
      introPages.add(IntroPage.fromMap(object));
    }
    // update ui
    notifyListeners();
  }

  final _duration = const Duration(milliseconds: 300);
  final _curve = Curves.easeIn;

  /// go to next page with 300 millisecond animation
  void animateToNextPage() {
    introductionPageController.nextPage(
      duration: _duration,
      curve: _curve,
    );
  }

  /// back to previous page with 300 millisecond animation
  void animateToPreviousPage() {
    introductionPageController.previousPage(
      duration: _duration,
      curve: _curve,
    );
  }

  /// tracking witch page is currently shown
  int currentPageIndex = 0;

  /// update [currentPageIndex] value when page is change
  void updateCurrentPageIndex(int newIndex) {
    if (currentPageIndex == newIndex) return;
    currentPageIndex = newIndex;
    notifyListeners();
  }

  /// set [`isFirstApplicationOpen`] value in local storage = false
  /// goto home screen
  Future<void> finish() async {
    await prefService.setIsApplicationFirstStart(false);
    pushClear(HomeScreen(), HomeProvider());
  }
}
