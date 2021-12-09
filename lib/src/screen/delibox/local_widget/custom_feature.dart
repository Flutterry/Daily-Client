import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/delibox/local_model/feature_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomFeature extends StatelessWidget {
  final List<FeatureModel> features;
  final FeatureWidgetId widgetId;
  final bool isLoading;

  const CustomFeature(this.features, this.widgetId, this.isLoading);

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const SpinKitRipple(color: amber);

    final featureModels = features.where(
      (element) => element.widgetId == enumToString(widgetId),
    );

    if (featureModels.isEmpty) {
      return const Visibility(visible: false, child: SizedBox.shrink());
    }

    final feature = featureModels.first;

    final largeTile = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: SizedBox(
                width: getWidth(12),
                height: getWidth(12),
                child: SvgPicture.network(feature.image),
              ),
            ),
            CustomText(
              text: feature.name,
              fontSize: 7,
              align: TextAlign.center,
              maxLines: 2,
              fontWeight: FontWeight.bold,
            ),
          ],
        )
      ],
    );

    final smallTile = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            width: getWidth(12),
            height: getWidth(12),
            child: SvgPicture.network(feature.image),
          ),
        ),
        CustomText(
          text: feature.name,
          fontSize: 7,
          align: TextAlign.center,
          maxLines: 2,
          fontWeight: FontWeight.bold,
        ),
      ],
    );

    return GestureDetector(
      onTap: () {
        switch (widgetId) {
          case FeatureWidgetId.restaurant:
            push(
              RestaurantsScreen(),
              RestaurantsProvider(feature.id),
            );
            break;
          case FeatureWidgetId.explore:
            // TODO: Handle this case.
            break;
          case FeatureWidgetId.stores:
            // TODO: Handle this case.
            break;
          case FeatureWidgetId.delivery_companies:
            // TODO: Handle this case.
            break;
          case FeatureWidgetId.productive_families:
            // TODO: Handle this case.
            break;
          case FeatureWidgetId.cafes:
            // TODO: Handle this case.
            break;
          case FeatureWidgetId.pharmacies:
            // TODO: Handle this case.
            break;
        }
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: grey.withOpacity(0.3),
        ),
        child: feature.widgetId == enumToString(FeatureWidgetId.explore)
            ? largeTile
            : smallTile,
      ),
    );
  }
}
