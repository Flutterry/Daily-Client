import 'package:bot_toast/bot_toast.dart';
import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/product/local_model/product_model.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductProvider extends ChangeNotifier {
  final dioService = DioService.getInstance();
  final prefService = PrefService.getInstance();

  final int productId;
  final CompanyModel company;

  /// counter of request product
  /// this value will change from only two function [addOneMore] and [subOneMore]
  int quantity = 1;

  /// product note, this is not required from client to write anything in note field
  final noteTextController = TextEditingController();

  /// quantity ++
  void addOneMore() {
    quantity++;
    notifyListeners();
  }

  /// quantity -- if any only if current quantity greater than 1
  void subOneMore() {
    if (quantity <= 1) return;
    quantity--;
    notifyListeners();
  }

  /// select and unselect extra
  void onSelectExtra(int extraIndex, bool? newValue) {
    product?.extras[extraIndex].selected = newValue ?? false;
    notifyListeners();
  }

  ProductProvider(this.productId, this.company) {
    _loadProductDetails();
  }

  /// contain all product details
  ProductModel? product;

  /// this method will call only once product screen is open
  Future<void> _loadProductDetails() async {
    final result = await dioService.get(productApi(productId));
    if (result.response == null) return pop();

    product = ProductModel.fromMap(result.response!.data);
    notifyListeners();
  }

  /// current selected size id
  late int selectedSizeId = product?.attributes.first.id ?? -1;

  /// it will select on new size
  /// and remove selection from all other sizes
  /// finally refresh ui
  void onSizeChange(int? newSelectedSizeId) {
    if (selectedSizeId == newSelectedSizeId) return;
    selectedSizeId = newSelectedSizeId ?? selectedSizeId;

    for (final attr in product!.attributes) {
      attr.selected = false;
    }
    product?.attributes
        .where((attr) => attr.id == selectedSizeId)
        .first
        .selected = true;

    notifyListeners();
  }

  /// getting total price of product (quantity, extras and size) are counted
  /// note that `VAT` not in the equation
  double total() => product?.totalPrice(quantity) ?? 0;

  Future<void> addToCart() async {
    final isAuth = await checkAuthorization();
    if (!isAuth) return;

    final extraIds = product!.extras
        .where((element) => element.selected)
        .map((e) => e.id)
        .toList();

    final data = {
      'product_id': productId,
      'quantity': quantity,
      'attribute_id': selectedSizeId,
      for (var i = 0; i < extraIds.length; i++) 'extras[$i]': extraIds[i],
      if (noteTextController.text.trim().isNotEmpty)
        'note': noteTextController.text.trim(),
    };
    final result = await dioService.post(
      cartApi,
      data: data,
      showLoading: true,
    );
    if (result.error == null) {
      BotToast.showText(text: tr('common.addedToCart'));
      pop();
    }
  }
}
