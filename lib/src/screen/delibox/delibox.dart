import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/delibox/local_model/feature_model.dart';
import 'local_widget/local_widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DeliboxScreen extends StatefulWidget {
  @override
  State<DeliboxScreen> createState() => _DeliboxScreenState();
}

class _DeliboxScreenState extends State<DeliboxScreen> {
  late DeliboxProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<DeliboxProvider>();
    final features = Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: CustomFeature(
                  provider.features,
                  FeatureWidgetId.explore,
                  provider.loadingFeature,
                ),
              ),
              Expanded(
                child: CustomFeature(
                  provider.features,
                  FeatureWidgetId.pharmacies,
                  provider.loadingFeature,
                ),
              ),
              Expanded(
                child: CustomFeature(
                  provider.features,
                  FeatureWidgetId.delivery_companies,
                  provider.loadingFeature,
                ),
              ),
            ],
          ),
        ),
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: CustomFeature(
                  provider.features,
                  FeatureWidgetId.productive_families,
                  provider.loadingFeature,
                ),
              ),
              Expanded(
                child: CustomFeature(
                  provider.features,
                  FeatureWidgetId.cafes,
                  provider.loadingFeature,
                ),
              ),
              Expanded(
                child: CustomFeature(
                  provider.features,
                  FeatureWidgetId.restaurant,
                  provider.loadingFeature,
                ),
              ),
              Expanded(
                child: CustomFeature(
                  provider.features,
                  FeatureWidgetId.stores,
                  provider.loadingFeature,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    final companiesNearToYou = provider.loadingNearMeCompanies
        ? const SpinKitRipple(color: amber)
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 32, right: 8, left: 8),
                child: CustomText(
                  tag: 'delibox.nearCompany',
                  fontSize: 12,
                  color: lightBlack,
                ),
              ),
              CustomScrollableRow(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: provider.nearCompanies
                    .map((e) => CustomCompany(e, fullWidth: false))
                    .toList(),
              ),
            ],
          );

    return Column(
      children: [
        if (provider.client != null)
          CustomClientAppBar(provider.client!, provider.welcomeMessage),
        Expanded(
          child: CustomScrollableColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              CustomBanners(provider.banners),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    features,
                  ],
                ),
              ),
              if (provider.loadingNearMeCompanies ||
                  provider.nearCompanies.isNotEmpty)
                companiesNearToYou,
              CustomBottomNavigationSpacer(),
            ],
          ),
        ),
      ],
    );
  }
}
