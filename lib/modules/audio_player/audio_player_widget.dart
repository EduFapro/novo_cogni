// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
//
// class AudioPlayerWidget extends StatefulWidget {
//   final String source;
//   final VoidCallback onDelete;
//
//   AudioPlayerWidget({required this.source, required this.onDelete});
//
//   @override
//   _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
// }
//
// class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
//   AudioPlayer? player;
//
//   @override
//   void initState() {
//     super.initState();
//     player = AudioPlayer();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         ElevatedButton(
//           child: Text("Play"),
//           onPressed: () async {
//             await player!.setSourceAsset(widget.source);
//             await player!.play(player!.source!);
//           },
//         ),
//         ElevatedButton(
//           child: Text("Stop"),
//           onPressed: () {
//             player!.stop();
//           },
//         ),
//         ElevatedButton(
//           child: Text("Delete"),
//           onPressed: widget.onDelete,
//         ),
//       ],
//     );
//   }
//
//   @override
//   void dispose() {
//     player!.dispose();
//     super.dispose();
//   }
// }
