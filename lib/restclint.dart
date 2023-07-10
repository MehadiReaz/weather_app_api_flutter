// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Future<Map> weatherGetRequest() async {
//   var url = Uri.parse(
//       'https://api.openweathermap.org/data/2.5/weather?q=Dhaka,+880&appid=d1840033ceeae46556982cd01e91d0e6');
//   var postHeader = {"Content-Type": "application/json"};
//   var response = await http.get(url, headers: postHeader);
//   print('aaaaa');
//   print(response.statusCode);
//   //var resultCode = response.statusCode;
//   var resultBody = json.decode(response.body);

//   return resultBody["main"];
// }
  // callWeatheData() async {
  //   inProgress = true;
  //   setState(() {});
  //   Response response = await get(Uri.parse(
  //       'https://api.openweathermap.org/data/2.5/weather?q=Dhaka,+880&appid=d1840033ceeae46556982cd01e91d0e6'));
  //   final Map<String, dynamic> decodedresponse = jsonDecode(response.body);
  //   //print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> mainData = decodedresponse['main'];
  //     final Weather weather = Weather.toJson(mainData);
  //     wetherStatus.add(weather);
  //   }
  //   setState(() {
  //     inProgress = false;
  //   });
  // }