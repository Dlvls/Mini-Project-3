import 'package:flutter/material.dart';

class TryPage extends StatelessWidget {
  const TryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Materi Cloud Messaging',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text(
          'This is the Cloud Messaging screen. Notifications will be shown when received.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:miniproject3/utility/helper/push_notification_helper.dart';
//
// class TryPage extends StatelessWidget {
//   const TryPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text(
//           'Materi Cloud Messaging',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.blue,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8),
//         child: ValueListenableBuilder<String?>(
//           valueListenable: PushNotificationHelper().payload,
//           builder: (context, value, child) {
//             final valueJson = PushNotificationHelper.tryDecode(value ?? '');
//
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     child: Text(
//                       'Notif Title: ${valueJson['title']}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     'Notif Content: ${valueJson['body']}',
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
