import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/restaurants/local_model/section_model.dart';
import 'package:flutter_svg/svg.dart';

class CustomTab extends StatelessWidget {
  static Color activeColor = deepAmber;
  static Color notActiveColor = lightBlack;

  final SectionModel tab;
  final bool selected;
  const CustomTab(this.tab, this.selected);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: IntrinsicWidth(
        child: Column(
          children: [
            SvgPicture.network(
              tab.image,
              width: getWidth(10),
              height: getWidth(10),
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 4,
              ),
              child: CustomText(
                text: tab.name,
                color: selected ? activeColor : notActiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
