import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:plants_ui/ui/componants/glassmorphism.dart';

class TextFormFieldWidget extends HookWidget {
  const TextFormFieldWidget(
      {super.key,
      required this.text,
      required this.keyboardType,
      required this.prefixIcon,
      this.validator,
      this.initialValue,
      this.onSaved,
      this.obscureText = false,
      this.suffixWidget,
      this.contentPadding});
  final bool obscureText;
  final String text;
  final TextInputType keyboardType;
  final Widget prefixIcon;
  final String? Function(String?)? validator;
  final String? initialValue;
  final Widget? suffixWidget;
  final void Function(String?)? onSaved;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    const primaryColor = Colors.greenAccent;
    final focusNode = useFocusNode();
    final hasFocus = useState(false);

    useEffect(
      () {
        focusNode.addListener(() {
          if (focusNode.hasFocus) {
            hasFocus.value = true;
          } else {
            hasFocus.value = false;
          }
        });
        return null;
      },
      [focusNode],
    );

    return Glassmorphism(
      padding: EdgeInsets.zero,
      widget: TextFormField(
        obscureText: obscureText,
        focusNode: focusNode,
        initialValue: initialValue,
        validator: validator,
        autofocus: false,
        keyboardType: keyboardType,
        onSaved: onSaved,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          hoverColor: Colors.white,
          contentPadding: hasFocus.value ? null : contentPadding,
          focusColor: primaryColor,
          border: InputBorder.none,
          prefixIcon: prefixIcon,
          labelText: text,
          suffix: suffixWidget,
          errorStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          prefixIconColor: hasFocus.value ? primaryColor : Colors.white,
          labelStyle: TextStyle(
            color: hasFocus.value ? primaryColor : Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
