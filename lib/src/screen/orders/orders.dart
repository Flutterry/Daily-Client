import 'package:daily_client/src/application.dart';

class OrdersScreen extends StatefulWidget {
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late OrdersProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<OrdersProvider>();
    return const Scaffold(body: CustomSoon());
  }
}
