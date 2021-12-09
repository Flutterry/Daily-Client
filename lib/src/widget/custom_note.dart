import 'package:daily_client/src/application.dart';
import 'package:sizer/sizer.dart';

class CustomNote extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const CustomNote(this.controller, this.hint, {this.maxLines = 2});

  @override
  Widget build(BuildContext context) {
    final borderDecoration = OutlineInputBorder(
      borderSide: const BorderSide(color: grey),
      borderRadius: BorderRadius.circular(8),
    );
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        fillColor: Colors.white.withOpacity(0.8),
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 10.0.sp,
          color: lightBlack,
        ),
        border: borderDecoration,
        enabledBorder: borderDecoration,
        focusedBorder: borderDecoration,
      ),
    );
  }
}
