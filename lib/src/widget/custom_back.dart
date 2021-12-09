import 'package:daily_client/src/application.dart';

class CustomBack extends StatelessWidget {
  final bool withRowPosition;
  const CustomBack({this.withRowPosition = false});
  @override
  Widget build(BuildContext context) {
    return withRowPosition
        ? Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Row(
              children: [
                GestureDetector(
                  onTap: pop,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(Icons.arrow_back_ios_outlined),
                  ),
                ),
              ],
            ),
          )
        : GestureDetector(
            onTap: pop,
            child: const Icon(Icons.arrow_back_ios_outlined),
          );
  }
}
