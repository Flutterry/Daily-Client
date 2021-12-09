import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/product/local_model/product_model.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomProductExtras extends StatelessWidget {
  final ProductModel product;
  final void Function(int, bool?) onSelectExtra;
  const CustomProductExtras(this.product, this.onSelectExtra);

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
          text: tr('product.extras'),
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: lightBlack,
        ),
        trailing: Icon(
          Icons.arrow_drop_down_circle_rounded,
          color: Colors.black.withOpacity(0.5),
        ),
        children: [
          Column(
            children: product.extras
                .asMap()
                .entries
                .map(
                  (extra) => ListTile(
                    title: CustomText(
                      text: extra.value.name,
                      fontWeight: FontWeight.w700,
                      color: lightBlack,
                    ),
                    trailing: CustomText(
                      text: tr(
                        'common.amount',
                        args: [extra.value.price.toStringAsFixed(2)],
                      ),
                      color: lightBlack,
                    ),
                    leading: Checkbox(
                      activeColor: amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      value: extra.value.selected,
                      onChanged: (newValue) =>
                          onSelectExtra(extra.key, newValue),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
