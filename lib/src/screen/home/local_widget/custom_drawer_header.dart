import 'package:cached_network_image/cached_network_image.dart';
import 'package:daily_client/src/application.dart';

class CustomDrawerHeader extends StatelessWidget {
  final Client client;

  const CustomDrawerHeader({Key? key, required this.client}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(100),
      height: getHeight(25),
      color: amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ListTile(
            leading: client.avatar == null
                ? null
                : CircleAvatar(
                    radius: 30,
                    backgroundImage: CachedNetworkImageProvider(
                      client.avatar.toString(),
                    ),
                  ),
            title: CustomText(
              text: client.name,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
