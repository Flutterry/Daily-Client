import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/about/local_model/about_model.dart';

class AboutProvider extends ChangeNotifier {
  final dioService = DioService.getInstance();

  /// contain data that getting from server after [loadAboutData] method is called
  AboutModel? about;

  AboutProvider() {
    _loadAboutData();
  }

  /// loading about data from server
  /// refresh ui
  /// if error return
  Future<void> _loadAboutData() async {
    final result = await dioService.get(aboutApi);
    if (result.response == null) return pop();
    about = AboutModel.fromMap(result.response!.data);
    notifyListeners();
  }
}
