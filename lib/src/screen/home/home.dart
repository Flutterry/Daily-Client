import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/home/local_widget/local_widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<HomeProvider>();
    return WillPopScope(
      onWillPop: provider.canPop,
      child: Scaffold(
        drawer: CustomDrawer(),
        body: Stack(
          children: [
            Positioned.fill(child: provider.getCurrentSelectedPage()),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomNavigationBar(
                onChange: provider.changeCurrentPageIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
