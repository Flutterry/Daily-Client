import 'package:daily_client/src/application.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late AccountProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<AccountProvider>();
    return const Scaffold(body: CustomSoon());
  }
}
