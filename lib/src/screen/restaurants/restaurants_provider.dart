import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/restaurants/local_model/local_models.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class RestaurantsProvider extends ChangeNotifier {
  final prefService = PrefService.getInstance();
  final dioService = DioService.getInstance();

  /// it's feature id for restaurant feature
  final int id;
  RestaurantsProvider(this.id) {
    loadRestaurants();
  }

  /// listen to scroll position
  final itemPositionsListener = ItemPositionsListener.create();

  /// control scrolling  ex. goto some scroll index
  final itemScrollController = ItemScrollController();

  /// will be false after companies request is finish in this method [`loadRestaurants`]
  bool isLoading = true;

  /// contain all restaurant with there tags in user location
  final sections = <SectionModel>[];

  /// this list is a same as `sections` list but in a new format to more performance when
  /// view it in a listView
  /// it will be a dynamic list that have a `tabs` and `companies`
  final restaurants = [];

  /// witch tab is active
  /// will active while scrolling or when click on Tab
  int selectedTabIndex = 0;

  /// this method will call in two cases:  first case when open restaurant screen
  /// second case when user change his location
  /// always clear previous data
  /// getting new address
  /// request all restaurant with there tags
  /// if there is an error close screen
  /// start listen to restaurant list scroll position
  /// finally filling restaurants list to improve performance
  Future<void> loadRestaurants() async {
    sections.clear();
    restaurants.clear();

    notifyListeners();
    _getAddress();

    final lastKnowLocation = prefService.getCurrentLocation();
    final data = {
      'lat': lastKnowLocation?.latitude,
      'lng': lastKnowLocation?.longitude,
      'feature_id': id,
    };
    final result = await dioService.get(restaurantApi, queryParameters: data);

    if (result.response == null) return pop();

    for (final section in result.response!.data!) {
      sections.add(SectionModel.fromMap(section));
    }

    for (final section in sections) {
      restaurants.add(section);
      restaurants.addAll(section.companies);
    }

    _initScrollPositionListener();
    isLoading = false;
    notifyListeners();
  }

  /// listening to current scroll position and active his tab
  void _initScrollPositionListener() {
    itemPositionsListener.itemPositions.addListener(() {
      final currentScrollIndex =
          itemPositionsListener.itemPositions.value.first.index;

      for (var i = sections.length - 1; i >= 0; i--) {
        final tabIndexInList = restaurants.indexOf(sections[i]);
        if (tabIndexInList <= currentScrollIndex) {
          if (selectedTabIndex != i) {
            selectedTabIndex = i;
            notifyListeners();
          }
          break;
        }
      }
    });
  }

  /// set a newTabIndex id
  /// scroll to first company in this tab
  Future<void> onTapChange(int newTabIndex) async {
    final tabIndexInRestaurantList = restaurants.indexOf(sections[newTabIndex]);

    await itemScrollController.scrollTo(
      index: tabIndexInRestaurantList,
      duration: const Duration(seconds: 1),
    );
    selectedTabIndex = newTabIndex;
    notifyListeners();
  }

  /// it will store address after ['_getAddress()'] method finish
  String address = '';

  /// returning address from coordinates
  Future<void> _getAddress() async {
    final currentLocation = prefService.getCurrentLocation();
    try {
      final result = await GeocodingPlatform.instance.placemarkFromCoordinates(
        currentLocation?.latitude ?? 0.0,
        currentLocation?.longitude ?? 0.0,
      );
      address = result.first.subAdministrativeArea ?? '';
      notifyListeners();
    } catch (_) {}
  }

  /// this method check if there is an authorized client data in storage first
  /// if there is a data: make a request to server to get all previous locations ond open a dialog with this location and option to adding a new location
  /// if not: just open a map to get a location
  /// last thing this method do: it's called [`_getAddress()`] to convert coordinates to address
  Future<void> changeLocation() async {
    if (prefService.getClient() == null) {
      await push(LocationScreen(), LocationProvider());
    } else {
      final result = await dioService.get(locationApi);
      if (result.response == null) return;
      if (result.response!.data.isEmpty) {
        await push(LocationScreen(), LocationProvider());
      } else {
        final previousLocations = <LocationModel>[];
        for (final location in result.response!.data) {
          previousLocations.add(LocationModel.fromMap(location));
        }
        await _showLocationPickerDialog(previousLocations);
      }
    }
    _getAddress();
    loadRestaurants();
  }

  /// take a list of previous location and show dialog to choose from this location or pick new location
  Future<void> _showLocationPickerDialog(List<LocationModel> locations) async {
    final addNewLocation = ListTile(
      onTap: () async {
        await push(LocationScreen(), LocationProvider());
        pop();
      },
      leading: const Icon(Icons.add_location_alt),
      title: const CustomText(
        tag: 'restaurants.addNewLocation',
        fontSize: 9,
      ),
    );

    // ignore: prefer_function_declarations_over_variables
    final locationTile = (location) {
      return Column(
        children: [
          SizedBox(width: getWidth(100)),
          ListTile(
            onTap: () async {
              await prefService.setCurrentLocation(
                LocationData.fromMap(
                  {
                    'latitude': location.lat,
                    'longitude': location.lng,
                  },
                ),
              );
              pop();
            },
            leading: const Icon(Icons.location_on),
            trailing: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () async {
                await dioService.delete(
                  locationApi,
                  parameter: location.id.toString(),
                  showLoading: true,
                );
                pop();
              },
            ),
            title: CustomText(
              text: location.label,
              fontSize: 9,
            ),
          ),
          const Divider(),
        ],
      );
    };

    await showDialog(
      context: ContextService.context,
      builder: (_) => AlertDialog(
        content: CustomScrollableColumn(
          children: [
            ...locations.map(locationTile),
            addNewLocation,
          ],
        ),
      ),
    );
  }

  /// this list contain all search suggestions
  final suggestions = <CompanyModel>[];

  /// searching for company using company name
  Future<void> search(String? query) async {
    suggestions.clear();
    notifyListeners();
    if (query == null || query.trim().isEmpty) return;

    final location = prefService.getCurrentLocation();
    final data = {
      'lat': location?.latitude,
      'lng': location?.longitude,
      'q': query,
    };
    final result = await dioService.get(
      searchRestaurantApi,
      queryParameters: data,
    );
    if (result.response == null) return;
    for (final company in result.response!.data) {
      suggestions.add(CompanyModel.fromMap(company));
    }
    notifyListeners();
  }

  /// linked to custom search field
  final searchController = TextEditingController();

  /// clearing suggestions and clear search query
  /// close keyboard
  void clearSearchSuggestions() {
    suggestions.clear();
    searchController.clear();
    FocusScope.of(ContextService.context).requestFocus(FocusNode());
    notifyListeners();
  }
}
