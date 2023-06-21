// import 'package:flutter/material.dart';

// import 'word.model.dart';

// // ignore: must_be_immutable
// class DetailScreen extends StatefulWidget {
//   List<WordModel> list = [];
//   int idx;
//   DetailScreen({
//     super.key,
//     required this.list,
//     required this.idx,
//   });

//   @override
//   State<DetailScreen> createState() => _DetailScreenState();
// }

// class _DetailScreenState extends State<DetailScreen> {
//   bool isOpen = false;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         border: Border.symmetric(),
//         color: Color.fromARGB(255, 231, 231, 231),
//       ),
//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: Text(
//               (widget.idx + 1).toString(),
//               style: const TextStyle(fontSize: 30),
//             ),
//           ),
//           const SizedBox(
//             height: 100,
//           ),
//           Text(
//             widget.list[widget.idx].wordEng,
//             style: const TextStyle(
//               fontSize: 70,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Row(
//             children: [
//               const SizedBox(
//                 width: 10,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     if (widget.idx != 0) {
//                       widget.idx--;
//                       isOpen = false;
//                     }
//                   });
//                 },
//                 child: const Icon(
//                   Icons.arrow_circle_left_outlined,
//                   size: 70,
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//                 width: MediaQuery.of(context).size.width - 160,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     if (widget.idx != widget.list.length - 1) {
//                       widget.idx++;
//                       isOpen = false;
//                     }
//                   });
//                 },
//                 child: const Icon(
//                   Icons.arrow_circle_right_outlined,
//                   size: 70,
//                 ),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//             ],
//           ),
//           Visibility(
//             visible: isOpen,
//             child: Text(
//               widget.list[widget.idx].wordKor,
//               style: const TextStyle(
//                 fontSize: 50,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Visibility(
//             visible: !isOpen,
//             child: ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   isOpen = true;
//                 });
//               },
//               style: ElevatedButton.styleFrom(
//                 fixedSize: const Size(100, 50),
//                 foregroundColor: Colors.white,
//                 backgroundColor: Colors.blue,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               child: const Text('정답'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
