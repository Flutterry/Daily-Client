import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/introduction/local_model/intro_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIntroPage extends StatelessWidget {
  final IntroPage introPage;
  const CustomIntroPage(this.introPage);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: getWidth(80),
          height: getWidth(80),
          child: SvgPicture.network(introPage.image),
        ),
        const SizedBox(height: 20),
        CustomText(
          text: introPage.title,
          color: amber,
          fontSize: 20,
          align: TextAlign.center,
          fontWeight: FontWeight.w700,
          maxLines: 2,
        ),
        const SizedBox(height: 5),
        CustomText(
          text: introPage.description,
          color: grey,
          align: TextAlign.center,
          maxLines: 10,
        ),
      ],
    );
  }
}
