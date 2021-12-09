import 'package:daily_client/src/application.dart';
import 'package:easy_localization/easy_localization.dart';

import 'local_widget/custom_item.dart';

class TypeYourOrderScreen extends StatefulWidget {
  @override
  State<TypeYourOrderScreen> createState() => _TypeYourOrderScreenState();
}

class _TypeYourOrderScreenState extends State<TypeYourOrderScreen> {
  late TypeYourOrderProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<TypeYourOrderProvider>();
    return CustomScrollableColumn(
      children: [
        const SizedBox(height: 50),
        CustomForm(
          marginTopPercent: 0,
          form: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const IconButton(onPressed: pop, icon: Icon(Icons.clear)),
              const CustomText(
                tag: 'typeYourOrder.title',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: lightBlack,
              ),
              const SizedBox(height: 12),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.items.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => CustomItem(
                  provider.items[index],
                  index,
                  provider.changeFocus,
                  provider.addOneMore,
                  provider.removeOneMore,
                ),
              ),
              TextButton(
                onPressed: provider.addOneMoreItem,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Icon(Icons.add_circle, color: amber),
                      SizedBox(width: 8),
                      CustomText(
                        tag: 'typeYourOrder.addNewItem',
                        fontWeight: FontWeight.w700,
                        color: grey,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
          text: tr('typeYourOrder.addToCart'),
          buttonWidth: getWidth(35),
          fontSize: 12,
          onPress: provider.addToCart,
        ),
        SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        const SizedBox(height: 50)
      ],
    );
  }
}
