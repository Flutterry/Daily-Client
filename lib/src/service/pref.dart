import 'dart:convert';

import 'package:daily_client/src/application.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  PrefService._();
  static final _instance = PrefService._();
  factory PrefService.getInstance() => _instance;
  //----------KEYs----------
  final _clientKey = 'CLIENT';
  final _introductionKey = 'INTRODUCTION';
  final _acceptLanguageKey = 'ACCEPT_LANGUAGE';
  final _darkThemeKey = 'DART_THEME';
  final _locationKey = 'LOCATION';
  final _notificationTokenKey = 'NOTIFICATION_TOKEN';
  //--------------------
  late SharedPreferences _pref;
  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  Future<void> clear() async {
    final currentLocation = getCurrentLocation();
    await _pref.clear();
    await setIsApplicationFirstStart(false);
    try {
      await setCurrentLocation(currentLocation!);
    } catch (_) {}
  }

  // --------------- client ---------------------
  Client? getClient() {
    if (_pref.getString(_clientKey) == null) return null;
    return Client.fromJson(_pref.getString(_clientKey)!);
  }

  Future<void> setClient(Client client) async {
    await _pref.setString(_clientKey, client.toJson());
  }

  // ---------------- language --------------------
  String getAcceptLanguage() {
    return _pref.getString(_acceptLanguageKey) ?? 'ar';
  }

  Future<void> setAcceptLanguage(String languageCode) async {
    await _pref.setString(_acceptLanguageKey, languageCode);
  }

  // ------------------ theme ------------------
  bool getIsDarkTheme() {
    return _pref.getBool(_darkThemeKey) ?? false;
  }

  Future<void> setIsDarkTheme(bool isDark) async {
    await _pref.setBool(_darkThemeKey, isDark);
  }

  // --------------- location ---------------------
  LocationData? getCurrentLocation() {
    if (_pref.getString(_locationKey) == null) return null;
    return LocationData.fromMap(jsonDecode(_pref.getString(_locationKey)!));
  }

  Future<void> setCurrentLocation(LocationData location) async {
    await _pref.setString(
      _locationKey,
      jsonEncode({
        'latitude': location.latitude,
        'longitude': location.longitude,
      }),
    );
  }

  // ---------------- notification token --------------------
  String getNotificationToken() {
    return _pref.getString(_notificationTokenKey) ?? '';
  }

  Future<void> setNotificationToken(String token) async {
    await _pref.setString(_notificationTokenKey, token);
  }

  // ---------------- introduction --------------------
  bool getIsApplicationFirstStart() {
    return _pref.getBool(_introductionKey) ?? true;
  }

  Future<void> setIsApplicationFirstStart(bool value) async {
    await _pref.setBool(_introductionKey, value);
  }
}
