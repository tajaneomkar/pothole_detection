import 'package:flutter/material.dart';
import 'package:pothole_detection/utils/common/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double? height;
  final List<Color>? gradientColors;
  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final Color? textColor;
  final Color? backgroundColor;
  final double? width;
  final bool isEnabled;
  final IconData? prefixIcon;
  final bool isLoading;
  final double? indicatorWidth;
  final double? indicatorHeight;
  final double? indicatorSize;
  final Color? buttonColor;
  final Color? iconColor;

  const CustomButton({
    Key? key,
    required this.onPressed,
    this.height,
    this.gradientColors,
    required this.text,
    this.fontSize,
    this.fontWeight = FontWeight.bold,
    this.fontFamily,
    this.textColor,
    this.width,
    this.isEnabled = true,
    this.backgroundColor,
    this.prefixIcon,
    this.isLoading = false,
    this.indicatorWidth,
    this.indicatorHeight,
    this.indicatorSize,
    this.buttonColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: isEnabled ? 1.0 : 0.2,
        child: InkWell(
          onTap:
              isEnabled ? onPressed : null, // Disable button when not enabled
          child: Container(
            width: width ?? double.infinity,
            height: height,
            decoration: BoxDecoration(
                color: buttonColor ?? const Color.fromARGB(255, 64, 255, 147),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: buttonColor ?? kcPrimaryColorDark)),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      height: indicatorHeight,
                      width: indicatorWidth,
                      child: const CircularProgressIndicator())
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (prefixIcon != null)
                          Icon(
                            prefixIcon,
                            color: iconColor ?? Colors.black,
                          ),
                        const SizedBox(width: 8),
                        Center(
                          child: Text(
                            text ?? "Custom Button",
                            style: TextStyle(
                              fontSize: fontSize,
                              fontWeight: fontWeight,
                              fontFamily: fontFamily,
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ));
  }
}
