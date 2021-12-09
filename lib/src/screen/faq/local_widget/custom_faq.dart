import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/screen/faq/local_model/faq_model.dart';

class CustomFaq extends StatelessWidget {
  final FaqModel faq;
  const CustomFaq(this.faq);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1),
        ],
      ),
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.all(16.0),
        title: CustomText(text: faq.question, fontSize: 12, maxLines: 10),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(width: double.infinity),
              CustomText(maxLines: 100, text: faq.answer),
            ],
          ),
        ],
      ),
    );
  }
}
