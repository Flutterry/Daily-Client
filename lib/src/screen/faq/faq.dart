import 'package:daily_client/src/application.dart';
import 'package:easy_localization/easy_localization.dart';

import 'local_widget/custom_faq.dart';

class FaqScreen extends StatefulWidget {
  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  late FaqProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<FaqProvider>();
    return Scaffold(
      body: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Column(
          children: [
            CustomAppBar(label: tr('faq.title'), back: true),
            Expanded(
              child: provider.faqs.isEmpty
                  ? const Center(child: CustomText(tag: 'faq.thereIsNoFaq'))
                  : ListView.builder(
                      itemCount: provider.faqs.length,
                      itemBuilder: (context, index) {
                        return CustomFaq(provider.faqs[index]);
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
