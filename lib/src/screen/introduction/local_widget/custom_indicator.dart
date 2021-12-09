import 'package:daily_client/src/application.dart';

class CustomIndicator extends StatelessWidget {
  final int length;
  final int selectedIndex;

  const CustomIndicator(this.length, this.selectedIndex);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(length, (index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            radius: 5,
            backgroundColor: index == selectedIndex ? amber : grey,
          ),
        );
      }),
    );
  }
}
