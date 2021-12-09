import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_client/src/application.dart';
import '../local_model/section_model.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomProduct extends StatelessWidget {
  final ProductModel product;
  final CompanyModel company;
  const CustomProduct(this.product, this.company);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => push(ProductScreen(), ProductProvider(product.id, company)),
      child: Container(
        margin: const EdgeInsets.only(right: 4, left: 4, top: 6, bottom: 2),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [BoxShadow(color: grey, blurRadius: 1)],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: product.image,
                fit: BoxFit.cover,
                width: getWidth(20),
                height: getWidth(20),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: CustomText(
                          text: product.name,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: amber,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                          size: getSize(25),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: CustomText(
                          maxLines: 2,
                          fontSize: 8,
                          color: grey,
                          text: product.description,
                        ),
                      ),
                      CustomText(
                        fontSize: 9,
                        text: tr(
                          'common.amount',
                          args: [product.price.toStringAsFixed(2)],
                        ),
                        color: amber,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
