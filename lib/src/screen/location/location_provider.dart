// ignore_for_file: use_build_context_synchronously

import 'package:daily_client/src/application.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:location/location.dart' as lo;

class LocationProvider extends ChangeNotifier {
  final prefService = PrefService.getInstance();
  final dioService = DioService.getInstance();
  final places = GooglePlace(googleApiKey);

  /// this field will contain coordinates value for current selected location on map
  late LatLng _currentLocation = LatLng(
    prefService.getCurrentLocation()?.latitude ?? 16.6011803,
    prefService.getCurrentLocation()?.longitude ?? 42.9347922,
  );

  /// this is initial selected location on map when screen open
  late CameraPosition initialCameraPosition = CameraPosition(
    target: _currentLocation,
    zoom: 16,
  );

  /// a constructor for this provider only do one thing =>
  /// set a marker for current location position on map
  LocationProvider() {
    _changeCurrentMarkerPosition(_currentLocation);
  }

  /// this controller will use to move and animate on map
  GoogleMapController? controller;

  /// always contain one marker: this marker present a client (current or selected) location
  final markers = <Marker>[];

  /// it will trigger when client tab a position on map or when client tab on pick my location icon
  /// then animate to this position
  /// then mark this location with marker
  void updateLocation(LatLng latLng) {
    _currentLocation = latLng;

    initialCameraPosition = CameraPosition(
      target: _currentLocation,
      zoom: 16,
    );
    controller?.animateCamera(
      CameraUpdate.newCameraPosition(initialCameraPosition),
    );
    _changeCurrentMarkerPosition(_currentLocation);
  }

  /// this variable will contain a 'client marker icon' to prevent performance issues
  dynamic _markerIcon;

  /// it will at when screen open and when client tab a new position on map
  /// it will clear all marker in [markers] list
  /// then add a new marker with a new position
  Future<void> _changeCurrentMarkerPosition(LatLng latLng) async {
    markers.clear();
    _markerIcon ??= await getMarkerIcon(
      BitmapDescriptor.fromAssetImage,
      getImage('location/marker.png'),
    );
    final newMarker = Marker(
      markerId: const MarkerId('client_location'),
      position: LatLng(_currentLocation.latitude, _currentLocation.longitude),
      icon: _markerIcon,
    );
    markers.add(newMarker);
    notifyListeners();
  }

  /// getting current location and animate to it on map
  Future<void> pickMyLocation() async {
    try {
      final location = await lo.Location.instance
          .getLocation()
          .timeout(const Duration(seconds: 5));
      if (location.latitude == null || location.longitude == null) return;
      updateLocation(LatLng(location.latitude!, location.longitude!));
      suggestions.clear(); // delete all items from search result
      notifyListeners();
    } catch (_) {}
  }

  /// if there is a authorized client data in local storage show a dialog to save this location in server and save it in local storage
  /// else just save it in local storage
  /// finally close map screen and back to restaurants screen
  Future<void> confirmLocation() async {
    if (prefService.getClient() != null) await _showSaveLocationDialog();
    await prefService.setCurrentLocation(
      lo.LocationData.fromMap({
        'latitude': _currentLocation.latitude,
        'longitude': _currentLocation.longitude,
      }),
    );
    pop();
  }

  /// this key will used in save location dialog
  final _formKey = GlobalKey<FormState>();

  /// will used in save location dialog
  final _saveLocationTextController = TextEditingController();

  /// shown a dialog if there is an authorized data in local storage
  /// this dialog is open to user so he can set a title for selected location
  Future<void> _showSaveLocationDialog() async {
    final alertDialog = AlertDialog(
      title: Text(tr('location.confirm.title')),
      content: Form(
        key: _formKey,
        child: CustomTextFormField.withLabel(
          controller: _saveLocationTextController,
          label: tr('location.confirm.label'),
          hint: tr('location.confirm.hint'),
          errorMsg: tr('location.confirm.error'),
          validation: textValidation,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;
            await dioService.post(
              locationApi,
              data: {
                'lat': _currentLocation.latitude,
                'lng': _currentLocation.longitude,
                'label': _saveLocationTextController.text,
              },
              showLoading: true,
            );
            pop();
          },
          child: Text(tr('location.confirm.ok')),
        )
      ],
    );
    await showDialog(
      context: ContextService.context,
      builder: (_) => alertDialog,
    );
    FocusScope.of(ContextService.context).requestFocus(FocusNode());
  }

  /// this is location search controller
  final searchController = TextEditingController();

  /// will contain all search results
  final suggestions = <AutocompletePrediction>[];

  /// will trigger every time client write something in ['custom search field']
  /// every time this method run must clear all previous search suggestions
  Future<void> onSearchQueryChange(String? query) async {
    suggestions.clear();
    if (query == null || query.trim().isEmpty) return notifyListeners();

    final result = await places.autocomplete.get(query.trim());
    if (result != null && result.predictions != null) {
      suggestions.addAll(result.predictions!);
    }

    notifyListeners();
  }

  /// it will trigger when user click on one item of [suggestions] list items
  /// it will get coordinates from suggestion address then clear suggestions list
  /// finally animate to this location on map
  Future<void> onSuggestionSelect(String address) async {
    try {
      final result =
          await GeocodingPlatform.instance.locationFromAddress(address);

      if (result.isEmpty) return;
      suggestions.clear();
      searchController.clear();

      FocusScope.of(ContextService.context).requestFocus(FocusNode());

      await Future.delayed(const Duration(milliseconds: 1500));
      updateLocation(LatLng(result.first.latitude, result.first.longitude));
    } catch (_) {}
  }
}
