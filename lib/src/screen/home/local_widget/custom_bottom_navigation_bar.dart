import 'package:daily_client/src/application.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'local_widgets.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final void Function(int) onChange;
  const CustomBottomNavigationBar({required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CustomPaint(
              size: Size(getWidth(100), getHeight(10)),
              painter: CustomBottomNavigationBarPainter(),
            ),
            SizedBox(
              width: getWidth(100),
              height: getHeight(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // first two items
                  Expanded(
                    child: CustomBottomNavigationBarItem(
                      label: tr('home.bottomNavigationBar.home'),
                      assetPath: getImage('home/home.svg'),
                      onClick: () => onChange(0),
                    ),
                  ),
                  Expanded(
                    child: CustomBottomNavigationBarItem(
                      label: tr('home.bottomNavigationBar.orders'),
                      assetPath: getImage('home/order.svg'),
                      onClick: () => onChange(1),
                    ),
                  ),
                  // this is white space to save daily logo position
                  const Expanded(child: SizedBox.shrink()),
                  // second two items
                  Expanded(
                    child: CustomBottomNavigationBarItem(
                      label: tr('home.bottomNavigationBar.offers'),
                      assetPath: getImage('home/offer.svg'),
                      onClick: () => onChange(2),
                    ),
                  ),
                  Expanded(
                    child: CustomBottomNavigationBarItem(
                      label: tr('home.bottomNavigationBar.account'),
                      assetPath: getImage('home/account.svg'),
                      onClick: () => onChange(3),
                    ),
                  ),
                ],
              ),
            ),
            // this is real center daily logo
            Positioned(
              top: -getHeight(3),
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {},
                child: Center(
                  child: SvgPicture.asset(
                    getImage('home/delibox.svg'),
                    width: getWidth(20),
                    height: getHeight(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
