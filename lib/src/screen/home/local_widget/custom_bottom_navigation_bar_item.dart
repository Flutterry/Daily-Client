import 'package:daily_client/src/application.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavigationBarItem extends StatelessWidget {
  final String label;
  final String assetPath;
  final void Function() onClick;

  const CustomBottomNavigationBarItem({
    Key? key,
    required this.label,
    required this.assetPath,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: SvgPicture.asset(assetPath)),
          Expanded(
            child: SizedBox(
              width: getWidth(20),
              child: CustomText(
                text: label,
                align: TextAlign.center,
                color: const Color(0xffC8C8C8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
