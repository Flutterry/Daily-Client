import 'package:daily_client/src/application.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ChatProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<ChatProvider>();
    return const Scaffold(body: CustomSoon());
  }
}
