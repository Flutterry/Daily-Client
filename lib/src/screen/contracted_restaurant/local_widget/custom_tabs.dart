import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/contracted_restaurant/local_model/section_model.dart';

import 'local_widgets.dart';

class CustomTabs extends StatelessWidget {
  final List<SectionModel> sections;
  final void Function(int) onClick;
  final int selectedIndex;

  const CustomTabs(this.sections, this.selectedIndex, this.onClick);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getWidth(100),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: sections
            .asMap()
            .entries
            .map(
              (section) => GestureDetector(
                onTap: () => onClick(section.key),
                child: CustomTab(section.value, section.key == selectedIndex),
              ),
            )
            .toList(),
      ),
    );
  }
}
