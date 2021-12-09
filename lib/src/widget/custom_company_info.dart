import 'package:daily_client/src/application.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCompanyInfo extends StatelessWidget {
  final CompanyModel company;
  const CustomCompanyInfo(this.company);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // row of name and icon
        // custom text contain an address
        // row of three column
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: company.name,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: lightBlack,
            ),
            const SizedBox(width: 4),
            SvgPicture.asset(
              getImage('contracted_restaurant/contracted.svg'),
              width: getSize(25),
            )
          ],
        ),
        CustomText(text: company.address, color: lightBlack),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!company.isOpen)
                      const CustomText(
                        tag: 'contracted.closed',
                        fontWeight: FontWeight.w700,
                        color: deepAmber,
                      ),
                    if (company.isOpen)
                      const CustomText(
                        tag: 'contracted.deliveryTime',
                        fontWeight: FontWeight.w700,
                        color: deepAmber,
                      ),
                    if (company.isOpen)
                      CustomText(
                        text: company.prepareTime,
                        fontSize: 8,
                        color: lightBlack,
                      ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: VerticalDivider(),
                ),
                Column(
                  children: [
                    const CustomText(
                      tag: 'contracted.minimumPurchase',
                      fontWeight: FontWeight.w700,
                      color: deepAmber,
                    ),
                    CustomText(
                      text: tr(
                        'common.amount',
                        args: [company.minimumPurchase],
                      ),
                      fontSize: 8,
                      color: lightBlack,
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: VerticalDivider(),
                ),
                Column(
                  children: [
                    const CustomText(
                      tag: 'contracted.deliveryPrice',
                      fontWeight: FontWeight.w700,
                      color: deepAmber,
                    ),
                    CustomText(
                      text: tr(
                        'common.amount',
                        args: [company.deliveryPrice],
                      ),
                      fontSize: 8,
                      color: lightBlack,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
