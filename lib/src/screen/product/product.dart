import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/product/local_widget/local_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProductScreen extends StatefulWidget {
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<ProductProvider>();

    final productTotalPriceWithoutVat = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: provider.addOneMore,
              icon: Icon(
                Icons.add_circle_outline_sharp,
                color: Colors.black.withOpacity(0.5),
                size: getSize(40),
              ),
            ),
            CustomText(
              text: provider.quantity.toString(),
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: lightBlack,
            ),
            IconButton(
              onPressed: provider.subOneMore,
              icon: Icon(
                Icons.remove_circle_outline_sharp,
                color: Colors.black.withOpacity(0.5),
                size: getSize(40),
              ),
            ),
          ],
        ),
        CustomText(
          text:
              tr('common.amount', args: [provider.total().toStringAsFixed(2)]),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        )
      ],
    );

    final confirmButton = Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: provider.addToCart,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                tag: 'product.addToCart',
                color: Colors.white,
                fontSize: 16,
              ),
              CustomText(
                text: tr(
                  'common.amount',
                  args: [provider.total().toStringAsFixed(2)],
                ),
                color: amber,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      body: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: [
              CustomAppBar(label: provider.company.name, back: true),
              Expanded(
                child: provider.product == null
                    ? const Center(child: SpinKitRipple(color: Colors.black))
                    : CustomScrollableColumn(
                        children: [
                          CustomProductInfo(provider.product!),
                          productTotalPriceWithoutVat,
                          CustomProductSizes(
                            provider.product!,
                            provider.onSizeChange,
                            provider.selectedSizeId,
                          ),
                          CustomProductExtras(
                            provider.product!,
                            provider.onSelectExtra,
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: CustomNote(
                              provider.noteTextController,
                              tr('common.noteHint'),
                              maxLines: 5,
                            ),
                          ),
                          confirmButton,
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
