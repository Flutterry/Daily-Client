import 'package:daily_client/src/application.dart';
import 'package:daily_client/src/widget/custom_app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pinput/pin_put/pin_put.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = context.watch<LoginProvider>();

    final pinCodeDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 1),
      ],
    );

    final loginForm = Form(
      key: provider.formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField.withLabelAndCode(
              label: tr('login.phone.label'),
              errorMsg: tr('login.phone.error'),
              hint: tr('login.phone.hint'),
              icon: Icons.call,
              textInputType: TextInputType.phone,
              code: provider.code,
              controller: provider.phoneController,
              validation: phoneValidation,
              enable: provider.canWritePhoneNumber,
            ),
            const CustomText(
              tag: 'login.pinCode.enterPinCodeHere',
              maxLines: 5,
              align: TextAlign.center,
            ),
            const SizedBox(height: 8),
            PinPut(
              controller: provider.pinController,
              fieldsCount: provider.pinDigitLength,
              followingFieldDecoration: pinCodeDecoration,
              selectedFieldDecoration: pinCodeDecoration,
              submittedFieldDecoration: pinCodeDecoration,
              withCursor: true,
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(label: tr('login.title'), back: true),
          Expanded(
            child: CustomScrollableColumn(
              children: [
                CustomForm(
                  blurRadius: 5,
                  form: loginForm,
                  onPress: provider.canWritePhoneNumber
                      ? provider.requestPinCode
                      : provider.login,
                  text: provider.canWritePhoneNumber
                      ? tr('login.pinCode.sendPin')
                      : tr('login.title'),
                ),
                const SizedBox(height: 25),
              ],
            ),
          )
        ],
      ),
    );
  }
}
