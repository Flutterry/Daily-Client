import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_client/src/application.dart';

class CustomBanners extends StatelessWidget {
  final List<String> banners;
  const CustomBanners(this.banners);

  @override
  Widget build(BuildContext context) {
    if (banners.isEmpty) return const SizedBox.shrink();
    return CarouselSlider.builder(
      options: CarouselOptions(
        aspectRatio: 16 / 7,
        viewportFraction: 0.9,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: banners.length * 3),
        enlargeCenterPage: true,
      ),
      itemCount: banners.length,
      itemBuilder: (_, index, __) => SizedBox(
        width: getWidth(100),
        height: getHeight(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            imageUrl: banners[index],
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
