import 'package:daily_client/src/application.dart';

class ServiceScreen extends StatefulWidget {
  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  late ServiceProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<ServiceProvider>();
    return const Scaffold(body: CustomSoon());
  }
}
