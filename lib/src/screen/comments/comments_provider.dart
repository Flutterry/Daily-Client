import 'package:daily_client/src/application.dart';

import 'local_model/comment_model.dart';

class CommentsProvider extends ChangeNotifier {
  final dioService = DioService.getInstance();

  final CompanyModel company;
  CommentsProvider(this.company) {
    loadComments();

    /// loading more comments if i scroll to half of comments length
    commentScrollController.addListener(() {
      if (commentScrollController.position.pixels * 2 >=
          commentScrollController.position.maxScrollExtent) {
        loadComments();
      }
    });
  }

  /// comment scroll controller to enable loadMore functionality
  final commentScrollController = ScrollController();

  /// this list will contain all company comments if it empty and loading value is false then:
  /// this company not have any comments yet
  final comments = <CommentModel>[];

  /// tracking if there is an ongoing request or not
  bool isLoading = false;

  /// current page on pagination requests
  int _currentPage = 1;

  /// number of pages on server
  int _lastPage = 1;

  /// this function will load comments as pagination
  Future<void> loadComments() async {
    if (isLoading || _currentPage > _lastPage) return;

    isLoading = true;
    notifyListeners();

    final result = await dioService.get(companyCommentsApi(company.id));
    isLoading = false;

    if (result.response == null) return notifyListeners();
    _currentPage++;
    _lastPage = result.response!.data['last_page'];

    for (final data in result.response!.data['data']) {
      comments.add(CommentModel.fromMap(data));
    }

    notifyListeners();
  }
}
