import 'package:daily_client/src/application.dart';

class MarketViewMoreScreen extends StatefulWidget {
  @override
  State<MarketViewMoreScreen> createState() => _MarketViewMoreScreenState();
}

class _MarketViewMoreScreenState extends State<MarketViewMoreScreen> {
  late MarketViewMoreProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<MarketViewMoreProvider>();
    return const Scaffold(body: CustomSoon());
  }
}
