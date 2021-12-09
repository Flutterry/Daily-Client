import 'package:daily_client/src/application.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late SettingsProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<SettingsProvider>();
    return const Scaffold(body: CustomSoon());
  }
}
