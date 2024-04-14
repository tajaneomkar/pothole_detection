import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pothole_detection/utils/common/app_colors.dart';

class CustomSearchDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;
  final String? initialValue;

  final bool? isEnable;
  final bool showSearchBox;
  final double? height;
  final String? Function(String?)? validator;

  const CustomSearchDropdown({
    Key? key,
    required this.items,
    this.selectedValue,
    this.onChanged,
    this.onSaved,
    this.height,
    this.validator,
    this.isEnable,
    this.initialValue,
    required this.showSearchBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      enabled: isEnable ?? true,
      selectedItem: selectedValue ?? initialValue,
      onChanged: (value) {
        if (value == null && selectedValue != null) {
          onChanged?.call(selectedValue);
        } else {
          onChanged?.call(value);
        }
      },
      popupProps: PopupProps.dialog(
          dialogProps: const DialogProps(
              backgroundColor: Color.fromARGB(255, 239, 240, 243),
              elevation: 8),
          listViewProps:
              const ListViewProps(dragStartBehavior: DragStartBehavior.down),
          loadingBuilder: (context, searchEntry) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          errorBuilder: (context, searchEntry, exception) {
            return const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("something went wrong"));
          },
          emptyBuilder: (context, searchEntry) {
            return const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text("No Data Found"),
            );
          },
          fit: FlexFit.loose,
          showSearchBox: showSearchBox),
      dropdownButtonProps: DropdownButtonProps(
          color: isEnable == true
              ? kcPrimaryColor
              : isEnable == false
                  ? Colors.grey
                  : kcPrimaryColor),
      dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: kcPrimaryColor)),
      )),
      items: items,
    );
  }
}
