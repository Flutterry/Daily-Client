import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_client/src/application.dart';

class CustomImageAppBar extends StatelessWidget {
  final String imageLink;
  const CustomImageAppBar(this.imageLink);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageLink,
      fit: BoxFit.cover,
      color: Colors.black.withOpacity(0.2),
      colorBlendMode: BlendMode.darken,
      width: getWidth(100),
      height: getHeight(30),
    );
  }
}
