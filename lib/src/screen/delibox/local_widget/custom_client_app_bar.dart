import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_client/src/application.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomClientAppBar extends StatelessWidget {
  final Client client;
  final String? welcomeMessage;
  const CustomClientAppBar(this.client, this.welcomeMessage);

  @override
  Widget build(BuildContext context) {
    final drawerIcon = IconButton(
      onPressed: () {
        if (Scaffold.of(context).hasDrawer) {
          Scaffold.of(context).openDrawer();
        }
      },
      icon: SvgPicture.asset(getImage('app_bar/menu.svg')),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          drawerIcon,
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: tr(
                    'delibox.hi',
                    args: [client.name],
                  ),
                ),
                CustomText(
                  text: welcomeMessage ?? '',
                  fontSize: 8,
                  color: grey,
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 25,
            backgroundImage: client.avatar == null
                ? null
                : CachedNetworkImageProvider(client.avatar!),
          ),
        ],
      ),
    );
  }
}
