import 'package:daily_client/src/application.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late LocationProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<LocationProvider>();
    final googleMap = GoogleMap(
      initialCameraPosition: provider.initialCameraPosition,
      onMapCreated: (mapController) => provider.controller = mapController,
      onTap: provider.updateLocation,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      markers: Set.from(provider.markers.map((e) => e)),
    );

    final searchResults = provider.suggestions.isEmpty
        ? const SizedBox.shrink()
        : SizedBox(
            height: getHeight(35),
            child: ListView.builder(
              itemBuilder: (context, index) {
                final e = provider.suggestions[index];
                return Card(
                  child: ListTile(
                    onTap: () => provider.onSuggestionSelect(
                      e.description.toString(),
                    ),
                    title: Text(e.structuredFormatting?.mainText ?? ''),
                    subtitle: Text(e.structuredFormatting?.secondaryText ?? ''),
                    leading: const Icon(Icons.location_city),
                  ),
                );
              },
              itemCount: provider.suggestions.length,
            ),
          );

    final pickCurrentLocationButton = GestureDetector(
      onTap: provider.pickMyLocation,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: const Icon(Icons.my_location),
      ),
    );

    final confirmLocationButton = GestureDetector(
      onTap: provider.confirmLocation,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: const Icon(Icons.check, color: Colors.white),
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          googleMap,
          Column(
            children: [
              CustomAppBar(label: tr('location.title'), back: true),
              CustomSearchField(
                provider.onSearchQueryChange,
                tr('location.searchHint'),
                controller: provider.searchController,
              ),
            ],
          ),
          Positioned(
            top: getHeight(15),
            left: 0,
            right: 0,
            child: searchResults,
          ),
          Positioned(
            left: 10,
            right: 10,
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                pickCurrentLocationButton,
                confirmLocationButton,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
