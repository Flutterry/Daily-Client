import 'package:daily_client/src/application.dart';

class WalletScreen extends StatefulWidget {
  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  late WalletProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<WalletProvider>();
    return const Scaffold(body: CustomSoon());
  }
}
