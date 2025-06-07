import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UgPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  const UgPhoneField({
    Key? key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.errorText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText ?? 'Phone Number',
        hintText: hintText ?? '772123456',
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 16, top: 14, right: 8),
          child: Text(
            '+256',
            style: TextStyle(fontSize: 16),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        errorText: errorText,
      ),
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(9),
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter phone number';
        }
        if (value.length != 9) {
          return 'Enter a valid 9-digit number';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
