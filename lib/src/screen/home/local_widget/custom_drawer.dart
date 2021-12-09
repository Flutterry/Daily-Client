import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/home/local_widget/local_widgets.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.read<HomeProvider>();
    return Drawer(
      child: Column(
        children: [
          if (provider.client != null)
            CustomDrawerHeader(client: provider.client!),
          Expanded(
            child: CustomScrollableColumn(
              children: [
                const SizedBox(height: 20),
                CustomDrawerItem(
                  title: tr('home.drawer.home'),
                  imagePath: getImage('drawer/home.svg'),
                  onPress: () {
                    pop();
                    provider.changeCurrentPageIndex(0);
                  },
                ),
                CustomDrawerItem(
                  title: tr('home.drawer.account'),
                  imagePath: getImage('drawer/user_info.svg'),
                  onPress: () {
                    pop();
                    push(AccountScreen(), AccountProvider());
                  },
                ),
                CustomDrawerItem(
                  title: tr('home.drawer.settings'),
                  imagePath: getImage('drawer/settings.svg'),
                  onPress: () {
                    pop();
                    push(SettingsScreen(), SettingsProvider());
                  },
                ),
                CustomDrawerItem(
                  title: tr('home.drawer.wallet'),
                  imagePath: getImage('drawer/wallet.svg'),
                  onPress: () {
                    pop();
                    if (provider.client == null) {
                      push(AccountScreen(), AccountProvider());
                    } else {
                      push(WalletScreen(), WalletProvider());
                    }
                  },
                ),
                CustomDrawerItem(
                  title: tr('home.drawer.faqs'),
                  imagePath: getImage('drawer/support.svg'),
                  onPress: () {
                    pop();
                    push(FaqScreen(), FaqProvider());
                  },
                ),
                CustomDrawerItem(
                  title: tr('home.drawer.about'),
                  imagePath: getImage('drawer/faq.svg'),
                  onPress: () {
                    pop();
                    push(AboutScreen(), AboutProvider());
                  },
                ),
                const SizedBox(height: 50),
                const Divider(),
                if (provider.client != null)
                  CustomDrawerItem(
                    title: tr('home.drawer.logout'),
                    imagePath: getImage('drawer/logout.svg'),
                    color: Colors.red,
                    onPress: provider.logOut,
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
