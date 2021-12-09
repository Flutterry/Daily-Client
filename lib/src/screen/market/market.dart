import 'package:daily_client/src/application.dart';

class MarketScreen extends StatefulWidget {
  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  late MarketProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<MarketProvider>();
    return const Scaffold(body: CustomSoon());
  }
}
