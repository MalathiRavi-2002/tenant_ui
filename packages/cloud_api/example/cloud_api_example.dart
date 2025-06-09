// import 'package:cloud_api/cloud_api.dart';

// void main() {
//   final api = CloudApi(basePath: 'http://192.168.1.73:3000');
//   api.login('919664065171', '1').then((value) {
//     value
//         .onSuccess((s) {
//           print('success:${s.token}');
//         })
//         .onFailure((e) {
//           print('error:${e.toString()}');
//         });
//   });
//   api
//       .register(
//         RegisterRequest(
//           mobile: "919664065170",
//           password: "1",
//           fullName: "Sana Sana",
//         ),
//       )
//       .then((value) {
//         value
//             .onSuccess((s) {
//               print('suc:${s.toString()}');
//             })
//             .onFailure((e) {
//               print('err:${e.toString()}');
//             });
//       });
//   api.updateProfile("judes").then((value) {
//     value
//         .onSuccess((s) {
//           print('suc:${s.toString()}');
//         })
//         .onFailure((e) {
//           print('err:${e.toString()}');
//         });
//   });
// }
