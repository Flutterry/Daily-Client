import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/contracted_restaurant/local_model/section_model.dart';

class CustomTab extends StatelessWidget {
  static Color activeColor = deepAmber;
  static Color notActiveColor = lightBlack;

  final SectionModel section;
  final bool isSelected;
  const CustomTab(this.section, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: IntrinsicWidth(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 4),
                child: CustomText(
                  text: section.name,
                  color: isSelected ? activeColor : notActiveColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
