import 'package:daily_client/src/application.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<SplashProvider>();
    return Scaffold(
      body: Image.asset(
        getImage('splash/intro.gif'),
        width: getWidth(100),
        height: getHeight(100),
        fit: BoxFit.cover,
      ),
    );
  }
}
