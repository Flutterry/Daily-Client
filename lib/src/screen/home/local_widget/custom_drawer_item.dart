import 'package:daily_client/src/application.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDrawerItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final Color color;
  final void Function() onPress;

  const CustomDrawerItem({
    Key? key,
    required this.title,
    required this.imagePath,
    this.color = lightBlack,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: SvgPicture.asset(imagePath, color: color),
      title: CustomText(text: title, fontSize: 12, color: color),
    );
  }
}
