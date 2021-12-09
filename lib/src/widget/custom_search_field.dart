import 'package:daily_client/src/application.dart';
import 'package:sizer/sizer.dart';

class CustomSearchField extends StatelessWidget {
  final void Function(String) onChange;
  final TextEditingController? controller;
  final String hint;
  const CustomSearchField(this.onChange, this.hint, {this.controller});

  @override
  Widget build(BuildContext context) {
    final borderDecoration = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.white),
    );
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: grey.withOpacity(0.1), blurRadius: 5),
        ],
      ),
      margin: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        onChanged: onChange,
        cursorColor: amber,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: borderDecoration,
          enabledBorder: borderDecoration,
          focusedBorder: borderDecoration,
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 14.0.sp,
            fontWeight: FontWeight.w700,
            color: grey,
          ),
          suffixIcon: const Icon(Icons.search, color: lightBlack),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    );
  }
}
