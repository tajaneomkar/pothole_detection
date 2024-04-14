// import 'package:flutter/material.dart';

// class IconMessagePopup extends StatelessWidget {
//   final IconData iconData;
//   final String message;
//   final Color iconColor;
//   final double iconSize;

//   const IconMessagePopup({
//     Key? key,
//     required this.iconData,
//     required this.message,
//     this.iconColor = Colors.blue,
//     this.iconSize = 48.0,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Icon(
//             iconData,
//             size: iconSize,
//             color: iconColor,
//           ),
//           const SizedBox(height: 16.0),
//           Text(
//             message,
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 16.0),
//           ),
//         ],
//       ),
//       actions: <Widget>[
//         IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';

class IconMessagePopup {
  static void show(BuildContext context,
      {required IconData iconData,
      required String message,
      required Color iconColor,
      required double iconSize,
      Color circleColor = Colors.transparent, // Default to transparent
      void Function()? onPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: circleColor,
                ),
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  iconData,
                  color: iconColor,
                  size: iconSize,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                message,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: onPressed,
                child: const Text(
                  'OK',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
