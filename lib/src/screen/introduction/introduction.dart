import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/introduction/local_widget/custom_indicator.dart';
import 'package:daily_client/src/screen/introduction/local_widget/custom_intro_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroductionScreen extends StatefulWidget {
  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  late IntroductionProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<IntroductionProvider>();

    final introPageView = PageView.builder(
      controller: provider.introductionPageController,
      itemCount: provider.introPages.length,
      onPageChanged: provider.updateCurrentPageIndex,
      itemBuilder: (context, index) {
        return CustomIntroPage(provider.introPages[index]);
      },
    );

    final backButton = TextButton(
      onPressed: provider.animateToPreviousPage,
      child: const CustomText(tag: 'introduction.back'),
    );

    final nextButton = TextButton(
      onPressed: provider.animateToNextPage,
      child: const CustomText(tag: 'introduction.next'),
    );

    final completeButton = TextButton(
      onPressed: provider.finish,
      child: const CustomText(tag: 'introduction.complete'),
    );

    return Scaffold(
      body: Stack(
        children: [
          // just a background image
          SvgPicture.asset(
            getImage('introduction/background.svg'),
            width: getWidth(100),
            height: getHeight(100),
            fit: BoxFit.cover,
          ),
          // real design page is 👇
          Column(
            children: [
              Expanded(child: introPageView),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  backButton,
                  CustomIndicator(
                    provider.introPages.length,
                    provider.currentPageIndex,
                  ),
                  if (provider.currentPageIndex ==
                      provider.introPages.length - 1)
                    completeButton // show this button if and only if client in last page
                  else
                    nextButton, // if pages have more show [nextButton]
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
