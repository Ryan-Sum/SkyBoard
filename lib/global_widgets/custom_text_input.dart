// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Iterable<String> autofillHints;
  final String hintText;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;

  const CustomTextInput({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.keyboardType,
    required this.autofillHints,
    required this.hintText,
    required this.textInputAction,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  bool showText = true;
  @override
  Widget build(BuildContext context) {
    if (widget.obscureText == false) {
      showText = false;
    }
    return TextFormField(
      validator: widget.validator,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
          ),
          hintText: widget.hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.black38),
          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      if (showText == true) {
                        showText = false;
                      } else {
                        showText = true;
                      }
                    });
                  },
                  icon: const Icon(Icons.remove_red_eye))
              : null),
      controller: widget.controller,
      obscureText: showText,
      autocorrect: false,
      keyboardType: widget.keyboardType,
      autofillHints: widget.autofillHints,
      textInputAction: widget.textInputAction,
    );
  }
}
