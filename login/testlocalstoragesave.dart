// import 'dart:convert';
// import 'dart:html' as html;

// class LocalStorageService {
//   static void saveUserData(Map<String, dynamic> userData) {
//     final String jsonString = jsonEncode(userData);
//     html.window.localStorage['userData'] = jsonString;
//   }

//   static Map<String, dynamic>? getUserData() {
//     final String? jsonString = html.window.localStorage['userData'];
//     if (jsonString != null) {
//       return jsonDecode(jsonString) as Map<String, dynamic>;
//     } else {
//       return null;
//     }
//   }
// }
