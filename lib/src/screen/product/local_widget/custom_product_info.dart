import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/product/local_model/product_model.dart';

class CustomProductInfo extends StatelessWidget {
  final ProductModel product;
  const CustomProductInfo(this.product);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: product.image,
              height: 350,
              width: getWidth(100),
              fit: BoxFit.cover,
            ),
          ),
        ),
        CustomText(
          text: product.name,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        CustomText(
          text: product.description,
          color: lightBlack,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Divider(color: Colors.black.withOpacity(0.2)),
        )
      ],
    );
  }
}
