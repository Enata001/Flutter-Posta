import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posta/utils/dimensions.dart';

class CTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final bool isPassword;
  final IconData? icon;
  final VoidCallback? action;

  const CTextField({
    super.key,
    this.controller,
    required this.hintText,
    required this.textInputType,
    this.isPassword = false,
    this.icon,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(
        context,
        color: Theme.of(context).colorScheme.secondary,
      ),
      borderRadius: BorderRadius.circular(
        Dimensions.textFieldBorderRadius,
      ),
    );
    return Container(
      margin: const EdgeInsets.only(
        top: Dimensions.textFieldSpacing,
      ),
      child: TextField(
        style: GoogleFonts.lato(
          fontSize: 16,
          color: Theme.of(context).colorScheme.scrim,
        ),
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: icon != null
              ? IconButton(
                  onPressed: action,
                  icon: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                )
              : null,
          labelText: hintText,
          alignLabelWithHint: true,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          contentPadding: const EdgeInsets.all(
            Dimensions.textFieldPadding,
          ),
        ),
        obscureText: isPassword,
        keyboardType: textInputType,
      ),
    );
  }
}
