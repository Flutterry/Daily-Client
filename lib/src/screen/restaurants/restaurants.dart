import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/restaurants/local_model/local_models.dart';
import 'package:daily_client/src/screen/restaurants/local_widget/local_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class RestaurantsScreen extends StatefulWidget {
  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  late RestaurantsProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<RestaurantsProvider>();
    final tabsAndSections = provider.isLoading
        ? const Center(child: SpinKitRipple(color: amber))
        : Column(
            children: [
              CustomTabs(
                provider.sections,
                provider.selectedTabIndex,
                provider.onTapChange,
              ),
              Expanded(
                child: ScrollablePositionedList.builder(
                  itemPositionsListener: provider.itemPositionsListener,
                  itemScrollController: provider.itemScrollController,
                  itemCount: provider.restaurants.length,
                  itemBuilder: (context, index) {
                    final item = provider.restaurants[index];
                    if (item is SectionModel) {
                      return index == 0
                          ? const SizedBox.shrink()
                          : Row(
                              children: [
                                CustomTab(item, false),
                              ],
                            );
                    } else {
                      return CustomCompany(item);
                    }
                  },
                ),
              ),
            ],
          );

    final searchSuggestions = Container(
      decoration: BoxDecoration(color: lightBlack.withOpacity(0.5)),
      height: getHeight(45),
      width: getWidth(100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: provider.clearSearchSuggestions,
            icon: const Icon(Icons.clear, color: Colors.white),
          ),
          Wrap(
            children: provider.suggestions
                .map((e) => CustomCompany(e, search: true))
                .toList(),
          ),
        ],
      ),
    );

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            label: provider.address,
            back: true,
            endIcon: IconButton(
              icon: const Icon(Icons.place_outlined),
              onPressed: provider.changeLocation,
            ),
          ),
          CustomSearchField(
            provider.search,
            tr('restaurants.search'),
            controller: provider.searchController,
          ),
          Expanded(
            child: Stack(
              children: [
                tabsAndSections,
                if (provider.suggestions.isNotEmpty) searchSuggestions,
              ],
            ),
          )
        ],
      ),
    );
  }
}
