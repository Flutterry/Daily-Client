import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/product/local_model/product_model.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomProductSizes extends StatelessWidget {
  final ProductModel product;
  final void Function(int?) onSizeChange;
  final int selectedSizeId;
  const CustomProductSizes(
    this.product,
    this.onSizeChange,
    this.selectedSizeId,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
          ),
        ],
      ),
      child: ExpansionTile(
        title: CustomText(
          text: tr('product.sizes'),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: lightBlack,
        ),
        trailing: Icon(
          Icons.arrow_drop_down_circle_rounded,
          color: Colors.black.withOpacity(0.5),
        ),
        children: [
          Row(
            children: product.attributes.map((size) {
              return Expanded(
                child: RadioListTile<int>(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  value: size.id,
                  groupValue: selectedSizeId,
                  activeColor: amber,
                  onChanged: onSizeChange,
                  title: CustomText(text: size.name),
                  subtitle: CustomText(
                    text: tr(
                      'common.amount',
                      args: [size.price.toStringAsFixed(2)],
                    ),
                    fontSize: 8,
                    color: lightBlack,
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
