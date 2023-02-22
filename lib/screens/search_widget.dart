// import 'package:flutter/material.dart';

// class SearchWidget extends StatefulWidget {
//   final String text;
//   final ValueChanged<String> onChanged;
//   final String hintText;
//   const SearchWidget({
//     Key? key,
//     required this.text,
//     required this.onChanged,
//     required this.hintText,
//   }) : super(key: key);

//   @override
//   State<SearchWidget> createState() => _SearchWidgetState();
// }

// class _SearchWidgetState extends State<SearchWidget> {
//   final controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final styleActive = TextStyle(color: Colors.black);
//     final styleHint = TextStyle(color: Colors.black54);

//     return Container(
//       height: 42,
//       margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: Colors.white,
//         border: Border.all(color: Colors.black26),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       child: TextField(
//         controller: controller,
//         hintText: Widget.hint
//     );
//   }
// }
