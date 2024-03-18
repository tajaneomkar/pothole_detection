import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pothole_detection/utils/common/app_colors.dart';

class AppInputField extends StatefulWidget {
  final TextEditingController? controller;
  final String label;
  final String hint;
  final Widget? leading;
  final Widget? trailing;
  final bool password;
  final bool enabled;
  final bool readOnly;
  final TextInputType? textInputType;
  final Color color;
  final double elevation;
  final FocusNode? focusNode;
  final int? maxLength;
  final int? maxLines;
  final int? minLength;
  final TextCapitalization? textCapitalization;
  final InputBorder? inputBorder;
  final void Function()? trailingTapped;
  final void Function(String)? onChanged;
  final FormFieldValidator<String>? validator;

  const AppInputField(
      {Key? key,
      this.controller,
      this.label = '',
      this.hint = '',
      this.leading,
      this.focusNode,
      this.trailing,
      this.trailingTapped,
      this.password = false,
      this.enabled = true,
      this.readOnly = false,
      this.elevation = 0,
      this.maxLength,
      this.maxLines,
      this.minLength,
      this.onChanged,
      this.inputBorder,
      this.color = Colors.transparent,
      this.textInputType = TextInputType.name,
      this.textCapitalization = TextCapitalization.sentences,
      TextStyle? hintStyle,
      this.validator})
      : super(key: key);

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
      /// Overriding the default blue color.
      ///
      /// We can also avoid this by changing the [primarySwatch] in MaterialApp
      data: Theme.of(context).copyWith(
        primaryColor: Colors.blue,
      ),
      child: Material(
        color: Colors.transparent,
        elevation: widget.elevation,
        child: TextFormField(
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          validator: widget.validator,
          enabled: widget.enabled,
          focusNode: widget.focusNode,
          onChanged: (val) {
            if (widget.onChanged != null) widget.onChanged!(val);
          },
          textCapitalization: widget.textCapitalization!,
          controller: widget.controller,
          keyboardType: widget.textInputType,
          minLines: widget.minLength,
          maxLines: widget.maxLines == null ? 1 : widget.maxLines,
          maxLength: widget.maxLength,
          readOnly: widget.readOnly,
          inputFormatters: <TextInputFormatter>[
            if (widget.textInputType == TextInputType.phone)
              LengthLimitingTextInputFormatter(10),
            if (widget.textInputType == TextInputType.phone)
              FilteringTextInputFormatter.digitsOnly,
            if (widget.textInputType == TextInputType.number)
              FilteringTextInputFormatter.digitsOnly,
            if (widget.textInputType ==
                const TextInputType.numberWithOptions(
                    decimal: true, signed: false))
              FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
            if (widget.textInputType ==
                const TextInputType.numberWithOptions(
                    decimal: true, signed: false))
              TextInputFormatter.withFunction((oldValue, newValue) {
                try {
                  final text = newValue.text;
                  if (text.isNotEmpty) double.parse(text);
                  return newValue;
                } catch (e) {
                  debugPrint("$e");
                }
                return oldValue;
              }),
          ],
          // Only numbers can be entered
          style: const TextStyle(height: 1.5, fontSize: 16),
          obscureText: widget.password,

          decoration: InputDecoration(
            hintText: widget.hint,
            labelText: widget.label,
            filled: true,
            fillColor: widget.color,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            prefixIcon: widget.leading,
            suffixIcon: widget.trailing != null
                ? GestureDetector(
                    onTap: widget.trailingTapped,
                    child: widget.trailing,
                  )
                : null,
            border: (widget.inputBorder ?? circularBorder).copyWith(
              borderSide: const BorderSide(color: kcDarkGreyColor),
            ),
            errorBorder: (widget.inputBorder ?? circularBorder).copyWith(
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedBorder: (widget.inputBorder ?? circularBorder).copyWith(
              borderSide: const BorderSide(color: kcPrimaryColor),
            ),
            enabledBorder: (widget.inputBorder ?? circularBorder).copyWith(
              borderSide: const BorderSide(
                color: kcPrimaryColor,
              ),
            ),
            disabledBorder: (widget.inputBorder ?? circularBorder).copyWith(
              borderSide: const BorderSide(color: kcPlaceholder),
            ),
            labelStyle: const TextStyle(fontSize: 16, color: appTextColor),
            hintStyle: const TextStyle(fontSize: 16, color: hintColor),
          ),
        ),
      ),
    );
  }
}
