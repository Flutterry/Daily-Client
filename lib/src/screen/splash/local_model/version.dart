import 'package:daily_client/src/application.dart';

extension VersionFunctions on Version {
  Future<bool> needToUpgrade() async {
    if (!require) return false;
    // this map have current buildNumber and versionCode
    final currentVersionInfo = await getApplicationVersion();
    myVersionCode = currentVersionInfo['code'];
    return builderNumber != currentVersionInfo['number'] ||
        versionCode != myVersionCode;
  }
}

class Version {
  Version({
    required this.builderNumber,
    required this.versionCode,
    required this.require,
    required this.notes,
  });

  /// it will be have a value only when [`needToUpgrade()`] method called
  String? myVersionCode;
  String builderNumber;
  String versionCode;
  bool require;
  String notes;

  factory Version.fromMap(Map<String, dynamic> json) => Version(
        builderNumber: json["builder_number"],
        versionCode: json["version_code"],
        require: json["required"] == 1,
        notes: json["notes"] == null ? '' : json["notes"].toString().trim(),
      );
}
