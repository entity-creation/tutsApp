// import 'dart:io';

// class PermissionHandler {
//   Future<bool> _hasAcceptedPermissions() async {
//     if (Platform.isAndroid) {
//       if (await _requestPermission(Permission.storage) &&
//           // access media location needed for android 10/Q
//           await _requestPermission(Permission.accessMediaLocation) &&
//           // manage external storage needed for android 11/R
//           await _requestPermission(Permission.manageExternalStorage)) {
//         return true;
//       } else {
//         return false;
//       }
//     }
//     if (Platform.isIOS) {
//       if (await _requestPermission(Permission.photos)) {
//         return true;
//       } else {
//         return false;
//       }
//     } else {
//       // not android or ios
//       return false;
//     }
//   }
// }
