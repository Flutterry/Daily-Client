import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_client/src/application.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCompany extends StatelessWidget {
  final CompanyModel company;
  final bool fullWidth;
  final bool search;
  const CustomCompany(
    this.company, {
    this.fullWidth = true,
    this.search = false,
  });

  @override
  Widget build(BuildContext context) {
    final tileWidth = search ? null : getWidth(fullWidth ? 100 : 60);
    final tileHeight = search ? null : getWidth(fullWidth ? 50 : 30);
    final avatarSize = fullWidth ? 35.0 : 20.0;

    /// company cover and avatar
    final topTile = ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: company.cover,
            fit: BoxFit.cover,
            width: tileWidth,
            height: tileHeight,
          ),
          Positioned(
            top: 10,
            right: 10,
            child: CircleAvatar(
              radius: avatarSize,
              backgroundImage: CachedNetworkImageProvider(company.avatar),
              // this stack just a darken cover on company avatar
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: avatarSize,
                    backgroundColor: Colors.black.withOpacity(0.1),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );

    final companyDetails = Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomText(
                text: company.name,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                CustomText(
                  text: tr('common.distance', args: [company.distance]),
                  fontSize: 8,
                  color: lightBlack,
                ),
                const SizedBox(width: 4),
                const Icon(Icons.location_on, size: 15)
              ],
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomText(
                text: company.description,
                color: lightBlack,
                fontSize: 6,
                maxLines: 8,
              ),
            ),
            Row(
              children: [
                CustomText(
                  text: company.prepareTime,
                  fontSize: 6,
                  color: grey,
                ),
                const SizedBox(width: 4),
                CustomText(
                  text: tr(
                    'common.deliveryPrice',
                    args: [company.deliveryPrice],
                  ),
                  fontSize: 6,
                  color: grey,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),
        if (company.discount != '0')
          Row(
            children: [
              SvgPicture.asset(getImage('delibox/offer.svg')),
              const SizedBox(width: 4),
              Expanded(
                child: CustomText(
                  text: tr(
                    'delibox.discount',
                    args: [company.discount],
                  ),
                  color: Colors.blueAccent,
                  fontSize: 7,
                ),
              ),
            ],
          )
      ],
    );

    final searchMode = Chip(
      label: CustomText(text: company.name),
      avatar: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(company.avatar),
      ),
    );
    return GestureDetector(
      onTap: () async {
        // if contracted open contracted restaurant screen
        // else open type your order dialog in same page
        if (company.contracted) {
          push(
            ContractedRestaurantScreen(),
            ContractedRestaurantProvider(company),
          );
        } else {
          final result = await checkAuthorization();
          if (result) {
            showModalBottomSheet(
              isScrollControlled: true,
              isDismissible: false,
              context: context,
              builder: (_) => ChangeNotifierProvider(
                create: (_) => TypeYourOrderProvider(company.id),
                child: TypeYourOrderScreen(),
              ),
            );
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(4),
        width: tileWidth,
        child: search
            ? searchMode
            : Column(
                children: [
                  topTile, // cover and avatar
                  companyDetails, // name, description, distance, prepareTime, discount
                ],
              ),
      ),
    );
  }
}
