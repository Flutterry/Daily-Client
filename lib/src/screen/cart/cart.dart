import 'package:daily_client/src/application.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<CartProvider>();
    return const Scaffold(body: CustomSoon());
  }
}
