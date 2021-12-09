import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/restaurants/local_model/section_model.dart';
import 'package:daily_client/src/screen/restaurants/local_widget/local_widgets.dart';

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
        children: sections.asMap().entries.map((e) {
          return GestureDetector(
            onTap: () => onClick(e.key),
            child: CustomTab(e.value, e.key == selectedIndex),
          );
        }).toList(),
      ),
    );
  }
}
