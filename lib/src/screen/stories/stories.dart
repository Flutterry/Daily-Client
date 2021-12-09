import 'package:daily_client/src/application.dart';

class StoriesScreen extends StatefulWidget {
  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends State<StoriesScreen> {
  late StoriesProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<StoriesProvider>();
    return const Scaffold(body: CustomSoon());
  }
}
