import 'package:daily_client/src/application.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  final bool back;
  final String label;
  final Widget? endIcon;

  const CustomAppBar({
    Key? key,
    this.back = false,
    required this.label,
    this.endIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backIcon = IconButton(
      onPressed: () => pop(),
      icon: const Icon(Icons.arrow_back_ios_rounded),
    );

    final drawerIcon = IconButton(
      onPressed: () {
        if (Scaffold.of(context).hasDrawer) {
          Scaffold.of(context).openDrawer();
        }
      },
      icon: SvgPicture.asset(getImage('app_bar/menu.svg')),
    );

    final emptyIcon = IconButton(
      onPressed: () {},
      icon: const SizedBox.shrink(),
    );

    return Container(
      width: getWidth(100),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        boxShadow: [BoxShadow(color: grey, blurRadius: 3)],
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const SizedBox(width: 16),
          if (back) backIcon else drawerIcon,
          Expanded(
            child: CustomText(
              text: label,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              align: TextAlign.center,
            ),
          ),
          endIcon ?? emptyIcon
        ],
      ),
    );
  }
}
