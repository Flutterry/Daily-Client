import 'package:daily_client/src/application.dart';

import 'local_model/faq_model.dart';

class FaqProvider extends ChangeNotifier {
  final dioService = DioService.getInstance();

  /// this is a list from questions and answers
  /// will be loaded at once (there is no pagination) when [loadFaq()] method in done
  final faqs = <FaqModel>[];

  /// this is just a constructor
  FaqProvider() {
    _loadFaq();
  }

  /// filling [faqs] list
  /// refresh api
  /// if error happened back to previous screen
  Future<void> _loadFaq() async {
    final result = await dioService.get(faqApi, showLoading: true);
    if (result.response == null) return pop();
    for (final object in result.response!.data) {
      faqs.add(FaqModel.fromMap(object));
    }
    notifyListeners();
  }
}
