import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/type_your_order/local_model/item_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sizer/sizer.dart';

class CustomItem extends StatelessWidget {
  final ItemModel item;
  final void Function(int) onCompleteEditing;
  final void Function(int) addOneMore;
  final void Function(int) removeOneMore;
  final int index;
  const CustomItem(
    this.item,
    this.index,
    this.onCompleteEditing,
    this.addOneMore,
    this.removeOneMore,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: item.itemTextController,
                  cursorColor: amber,
                  onEditingComplete: () => onCompleteEditing(index),
                  focusNode: item.focusNode,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: grey,
                      fontSize: 10.0.sp,
                    ),
                    hintText: tr('typeYourOrder.itemHint'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: amber),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => addOneMore(index),
                    icon: Icon(
                      Icons.add_circle_outline_sharp,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  CustomText(
                    text: item.quantity.toString(),
                    fontSize: 12,
                  ),
                  IconButton(
                    onPressed: () => removeOneMore(index),
                    icon: Icon(
                      Icons.remove_circle_outline_sharp,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: CustomNote(item.noteTextController, tr('common.noteHint')),
        )
      ],
    );
  }
}
