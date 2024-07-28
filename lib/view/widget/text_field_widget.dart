import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool? obscureText;
  final TextEditingController controller;
  final String? value;
  final String? Function(String?)? valid;
  final void Function()? onTapIcon;

  TextFieldWidget({
    required this.label,
    required this.hint,
    required this.icon,
    required this.valid,
    required this.controller,
    this.obscureText,
    this.onTapIcon,
    this.value,
    Key? key,
  }) : super(key: key);

  bool isV = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: ValueKey(value),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != '') Text(label),
        const SizedBox(height: 8),
        TextFormField(
          validator: valid,
          controller: controller,
          textAlign: TextAlign.start,
          obscureText:
              obscureText == null || obscureText == false ? false : true,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: hint,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            suffixIcon: InkWell(
              onTap: onTapIcon,
              child: obscureText != null
                  ? Icon(
                      obscureText == true
                          ? Icons.visibility_off
                          : Icons.visibility,
                    )
                  : const Icon(null),
            ),
          ),
        ),
      ],
    );
  }
}
