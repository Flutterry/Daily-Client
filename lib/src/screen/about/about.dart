import 'package:daily_client/src/application.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutScreen extends StatefulWidget {
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late AboutProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<AboutProvider>();
    final aboutHtml = provider.about == null
        ? const Center(
            child: CustomText(
              tag: 'about.aboutNotFound',
              fontSize: 12,
            ),
          )
        : CustomScrollableColumn(
            children: [
              const SizedBox(
                height: 45,
                width: double.infinity,
              ),
              Html(data: provider.about?.body),
            ],
          );
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(label: tr('about.title'), back: true),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: DottedBorder(
                radius: const Radius.circular(10),
                borderType: BorderType.RRect,
                dashPattern: const [5, 5],
                strokeCap: StrokeCap.round,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: aboutHtml,
                    ),
                    Positioned(
                      top: -40,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 0.5),
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 40,
                          child: SvgPicture.asset(
                            getImage('home/delibox.svg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
