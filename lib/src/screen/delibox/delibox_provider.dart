import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/delibox/local_model/feature_model.dart';

class DeliboxProvider extends ChangeNotifier {
  final dioService = DioService.getInstance();
  final prefService = PrefService.getInstance();

  DeliboxProvider() {
    loadWelcomeMessage();
    loadBanners();
    loadFeatures();
    loadNearMeCompanies();
  }

  /// return authorized data of current login client
  Client? get client => prefService.getClient();

  /// will be null if there is no authorized data in local storage
  String? welcomeMessage;

  /// loading welcome message if there is authorized client data in local storage
  Future<void> loadWelcomeMessage() async {
    if (client == null) return;

    final result = await dioService.get(
      welcomeMessageApi,
      faker: getDescription(),
    );
    if (result.response == null) return;
    welcomeMessage = result.response!.data;
    notifyListeners();
  }

  /// banners from server base on client location
  final banners = <String>[];

  /// loading ads banners from server base on client location
  Future<void> loadBanners() async {
    final result = await dioService.get(
      bannersApi,
      faker: List.generate(3, (index) => networkImage),
    );

    if (result.response == null) return;
    banners.addAll(result.response!.data!);
    notifyListeners();
  }

  /// feature loading indicator
  bool loadingFeature = true;

  /// have all available features in client location
  final features = <FeatureModel>[];

  /// fill [`features`] list
  Future<void> loadFeatures() async {
    final result = await dioService.get(featureApi);
    loadingFeature = false;
    if (result.response == null) return notifyListeners();

    for (final feature in result.response!.data) {
      features.add(FeatureModel.fromMap(feature));
    }
    notifyListeners();
  }

  /// company loading indicator
  bool loadingNearMeCompanies = true;

  /// have all near companies in client location
  final nearCompanies = <CompanyModel>[];

  /// fill [`nearCompanies`] list
  Future<void> loadNearMeCompanies() async {
    final query = {
      'lat': prefService.getCurrentLocation()?.latitude,
      'lng': prefService.getCurrentLocation()?.longitude,
    };
    final result = await dioService.get(nearMeApi, queryParameters: query);
    loadingNearMeCompanies = false;
    if (result.response == null) return notifyListeners();

    for (final company in result.response!.data) {
      nearCompanies.add(CompanyModel.fromMap(company));
    }
    notifyListeners();
  }
}
