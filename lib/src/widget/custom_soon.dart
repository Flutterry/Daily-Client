import 'package:daily_client/src/application.dart';

class CustomSoon extends StatelessWidget {
  const CustomSoon();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        getImage('common/coming_soon.png'),
      ),
    );
  }
}
