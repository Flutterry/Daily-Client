import 'package:daily_client/src/application.dart';
import 'local_model/section_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ContractedRestaurantProvider extends ChangeNotifier {
  final dioService = DioService.getInstance();
  final prefService = PrefService.getInstance();

  final CompanyModel company;
  ContractedRestaurantProvider(this.company) {
    loadProducts();
  }

  /// will have data after [loadProducts()] function called
  final sections = <SectionModel>[];

  /// this list is a same as `sections` list but in a new format to improve performance when
  /// view it in a listView
  /// it will be a dynamic list that have a `tabs` and `products`
  final products = [];

  /// will be false after loadingProduct finished
  bool isLoading = true;

  /// this method will called one
  /// it's request from server all product from this company
  Future<void> loadProducts() async {
    final currentLocation = prefService.getCurrentLocation();
    final result = await dioService.get(
      companyProductApi(company.id),
      queryParameters: {
        'lat': currentLocation?.latitude,
        'lng': currentLocation?.longitude,
      },
    );
    if (result.response == null) return pop();
    for (final section in result.response!.data['company_categories']) {
      sections.add(SectionModel.fromMap(section));
    }
    isLoading = false;

    for (final section in sections) {
      products.add(section);
      products.addAll(section.products);
    }

    _startListenToScrollPosition();

    notifyListeners();
  }

  /// just to listen to scroll position
  final itemPositionsListener = ItemPositionsListener.create();

  /// this controller control current position
  final itemScrollController = ItemScrollController();

  /// this method will listen to scroll position of product list
  /// and automatically check on correct product tab
  void _startListenToScrollPosition() {
    itemPositionsListener.itemPositions.addListener(() {
      final currentScrollIndex =
          itemPositionsListener.itemPositions.value.first.index;

      for (var i = sections.length - 1; i >= 0; i--) {
        final tabIndexInList = products.indexOf(sections[i]);
        if (tabIndexInList <= currentScrollIndex) {
          if (selectedTabIndex != i) {
            selectedTabIndex = i;
            notifyListeners();
          }
          break;
        }
      }
    });
  }

  /// contain current selected tab
  int selectedTabIndex = 0;

  /// change current selected tab
  Future<void> onTabChange(int newTabIndex) async {
    final tabIndexInRestaurantList = products.indexOf(sections[newTabIndex]);

    await itemScrollController.scrollTo(
      index: tabIndexInRestaurantList,
      duration: const Duration(seconds: 1),
    );
    selectedTabIndex = newTabIndex;
    notifyListeners();
  }
}
