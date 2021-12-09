import 'package:daily_client/src/application.dart';

class ServicesScreen extends StatefulWidget {
  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  late ServicesProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<ServicesProvider>();
    return const Scaffold(body: CustomSoon());
  }
}
