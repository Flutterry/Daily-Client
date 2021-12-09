import 'package:daily_client/src/application.dart';

class StoryScreen extends StatefulWidget {
  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  late StoryProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<StoryProvider>();
    return const Scaffold(body: CustomSoon());
  }
}
