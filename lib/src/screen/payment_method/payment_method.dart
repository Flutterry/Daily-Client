import 'package:daily_client/src/application.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  late PaymentMethodProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<PaymentMethodProvider>();
    return const Scaffold(body: CustomSoon());
  }
}
