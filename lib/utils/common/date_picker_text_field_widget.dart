import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pothole_detection/utils/common/app_colors.dart';

class DatePickerFormField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const DatePickerFormField({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  DatePickerFormFieldState createState() => DatePickerFormFieldState();
}

class DatePickerFormFieldState extends State<DatePickerFormField> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.light(
              surface: dashboardBackgorund,
              primary: kcPrimaryColorDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        widget.controller.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.blue,
      ),
      child: Material(
        color: Colors.transparent,
        child: TextFormField(
          validator: widget.validator,
          readOnly: true,
          controller: widget.controller,
          onTap: () => _selectDate(context),
          decoration: InputDecoration(
            hintText: widget.hint,
            labelText: widget.label,
            filled: true,
            fillColor: Colors.transparent,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today),
              color: kcPrimaryColorDark,
              onPressed: () => _selectDate(context),
            ),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            labelStyle: const TextStyle(fontSize: 16, color: appTextColor),
            hintStyle: const TextStyle(fontSize: 16, color: hintColor),
          ),
        ),
      ),
    );
  }
}
