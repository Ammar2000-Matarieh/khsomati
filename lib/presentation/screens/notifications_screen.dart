import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khsomati/constants/app_colors.dart';
import 'package:khsomati/constants/app_size.dart';
import 'package:khsomati/data/models/notifications_model.dart';
import 'package:lottie/lottie.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Lottie.asset("assets/lotties/coming soon.json")],
        ),
      ),
    );
  }
}
// class NotificationsScreen extends StatelessWidget {
//   const NotificationsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(CupertinoIcons.back, color: AppColors.white),
//         ),
//         backgroundColor: AppColors.primary,
//         title: Text(
//           "Notifications History",
//           style: TextStyle(
//             fontSize: 18,
//             color: AppColors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(height: 20),
//             Expanded(
//               child: ListView.separated(
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.of(context).push(
//                         CupertinoPageRoute(
//                           builder: (context) =>
//                               NotificationDetails(index: index),
//                         ),
//                       );
//                     },
//                     child: Hero(
//                       tag: "notif_$index",
//                       child: Material(
//                         color: Colors.transparent,
//                         child: Container(
//                           margin: EdgeInsets.symmetric(horizontal: 12),
//                           // padding: EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: AppColors.white,
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(
//                               color: AppColors.primary,
//                               width: 1.2,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black12,
//                                 blurRadius: 4,
//                                 offset: Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: ListTile(
//                             title: Text("sj"),
//                             subtitle: Text("ksnk"),
//                             trailing: Icon(CupertinoIcons.bell),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//                 separatorBuilder: (context, index) => SizedBox(height: 20),
//                 itemCount: 7,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class NotificationDetails extends StatelessWidget {
//   final int index;

//   const NotificationDetails({super.key, required this.index});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Notification Details",
//           style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w500),
//         ),
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(CupertinoIcons.back, color: AppColors.white),
//         ),
//         backgroundColor: AppColors.primary,
//       ),
//       body: Center(
//         child: Hero(
//           tag: "notif_$index",
//           child: Material(
//             color: Colors.transparent,
//             child: SingleChildScrollView(
//               // ← الحل هنا
//               child: Container(
//                 width: AppSize.width * 0.9,
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: AppColors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: AppColors.primary),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 10,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       "Hs",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 10),
//                     Text("sj", style: TextStyle(fontSize: 16)),
//                     SizedBox(height: 20),
//                     Icon(
//                       CupertinoIcons.bell,
//                       size: 40,
//                       color: AppColors.primary,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
