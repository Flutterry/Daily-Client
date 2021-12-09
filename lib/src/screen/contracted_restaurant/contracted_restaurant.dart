import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/contracted_restaurant/local_model/section_model.dart';
import 'package:daily_client/src/screen/contracted_restaurant/local_widget/local_widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ContractedRestaurantScreen extends StatefulWidget {
  @override
  State<ContractedRestaurantScreen> createState() =>
      _ContractedRestaurantScreenState();
}

class _ContractedRestaurantScreenState
    extends State<ContractedRestaurantScreen> {
  late ContractedRestaurantProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<ContractedRestaurantProvider>();
    final form = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 8),
        CustomCompanyInfo(provider.company),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(primary: Colors.white),
          onPressed: () {
            push(CommentsScreen(), CommentsProvider(provider.company));
          },
          icon: SvgPicture.asset(
            getImage('contracted_restaurant/comment.svg'),
          ),
          label: const CustomText(
            tag: 'contracted.rates',
            color: lightBlack,
          ),
        ),
        CustomTabs(
          provider.sections,
          provider.selectedTabIndex,
          provider.onTabChange,
        ),
        if (provider.isLoading)
          const Expanded(
            child: Center(child: SpinKitRipple(color: amber)),
          )
        else if (provider.sections.isEmpty)
          Expanded(
            child: Center(
              child: CustomText(
                tag: 'contracted.noProduct',
                color: lightBlack.withOpacity(0.5),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          )
        else
          Expanded(
            child: ScrollablePositionedList.builder(
              itemPositionsListener: provider.itemPositionsListener,
              itemScrollController: provider.itemScrollController,
              itemBuilder: (context, index) {
                final item = provider.products[index];
                if (item is SectionModel) {
                  return index == 0
                      ? const SizedBox.shrink()
                      : Row(
                          children: [
                            CustomTab(item, false),
                          ],
                        );
                } else {
                  return CustomProduct(item, provider.company);
                }
              },
              itemCount: provider.products.length,
            ),
          ),
      ],
    );

    final appBar = Stack(
      children: [
        CustomImageAppBar(provider.company.cover),
        Positioned(
          top: 10,
          left: 10,
          right: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const CustomBack(),
              ),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: const Icon(Icons.favorite_border),
              ),
            ],
          ),
        ),
      ],
    );
    return Scaffold(
      body: Stack(
        children: [
          appBar,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomForm(
              form: form,
              image: provider.company.avatar,
              imageRadius: 35,
            ),
          ),
        ],
      ),
    );
  }
}
