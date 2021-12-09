import 'package:bot_toast/bot_toast.dart';
import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/type_your_order/local_model/item_model.dart';
import 'package:easy_localization/easy_localization.dart';

class TypeYourOrderProvider extends ChangeNotifier {
  final dioService = DioService.getInstance();

  final items = <ItemModel>[ItemModel()];

  /// add new item to items list
  void addOneMoreItem() {
    items.add(ItemModel());
    notifyListeners();
  }

  /// company id: it will used when add to cart
  final int companyId;
  TypeYourOrderProvider(this.companyId);

  /// request focus to next item if current item is not the last item
  /// else clear focus
  void changeFocus(int index) {
    if (index < items.length - 1) {
      items[index + 1].focusNode.requestFocus();
    } else if (index == items.length - 1) {
      FocusScope.of(ContextService.context).requestFocus(FocusNode());
    }
  }

  /// add 1 to current quantity
  void addOneMore(int itemIndex) {
    items[itemIndex].quantity++;
    notifyListeners();
  }

  /// if current quantity is 1 and it's not only item in list then remove it
  /// else sub 1 from current quantity
  void removeOneMore(int itemIndex) {
    final item = items[itemIndex];
    if (item.quantity - 1 == 0) {
      if (items.length != 1) items.removeAt(itemIndex);
    } else {
      item.quantity--;
    }
    notifyListeners();
  }

  /// if all items is empty return
  /// then clear all empty item from list
  /// finally send items data to server
  Future<void> addToCart() async {
    // check if all items is empty
    if (items
        .where((element) => element.itemTextController.text.trim().isNotEmpty)
        .isEmpty) {
      BotToast.showText(text: tr('typeYourOrder.allItemsIsEmpty'));
      return;
    }

    // remove all empty items
    items.removeWhere(
      (element) => element.itemTextController.text.trim().isEmpty,
    );
    notifyListeners();

    // prepare data
    final data = {
      'company_id': companyId,
      for (var i = 0; i < items.length; i++) ...{
        'products[$i][name]': items[i].itemTextController.text.trim(),
        'products[$i][quantity]': items[i].quantity,
        if (items[i].noteTextController.text.trim().isNotEmpty)
          'products[$i][note]': items[i].noteTextController.text.trim(),
      },
    };
    // send request
    final result = await dioService.post(
      nonContractedCartApi,
      data: data,
      showLoading: true,
    );

    if (result.response == null) return;
    BotToast.showText(text: tr('common.addedToCart'));
    pop();
  }
}
