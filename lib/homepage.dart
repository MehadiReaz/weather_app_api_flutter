import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'weather.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FToast? fToast;

  @override
  void initState() {
    super.initState();
    callWeatheData();
    DateFormat('hh:mm a').format(DateTime.now());
    fToast = FToast();
    fToast!.init(context);
  }

  void showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: const Color.fromARGB(255, 80, 80, 80),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 12.0),
          Text(
            "Updated...",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );

    fToast?.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  void showToastError() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: const Color.fromARGB(255, 80, 80, 80),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 12.0),
          Text(
            "No Internet Connection",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );

    fToast?.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  List<Weather> wetherStatus = [];
  List<WeatherType> weatherType = [];
  //DateTime time;
  //String wetherStatus= '';
  bool inProgress = false;
  String loc = '';

  callWeatheData() async {
    inProgress = true;
    setState(() {});
    Response response = await get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=Dhaka,+880&appid=d1840033ceeae46556982cd01e91d0e6'));
    final Map<String, dynamic> decodedresponse = jsonDecode(response.body);

    //print(response.statusCode);
    if (response.statusCode == 200) {
      showToast();
      final Map<String, dynamic> mainData = decodedresponse['main'];
      //final Map<String, dynamic> weatherType = decodedresponse['weather'];
      //final WeatherType type = WeatherType.toJson(weatherType);
      final Weather weather = Weather.toJson(mainData);
      final String location = decodedresponse['name'];
      loc = location;
      wetherStatus.add(weather);
      for (var e in decodedresponse['weather']) {
        weatherType.add(WeatherType.toJson(e));
      }
    } else {
      showToastError();
    }
    setState(() {
      inProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7C51FE),
        title: const Text('Weather App'),
        elevation: 5,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          callWeatheData();
        },
        child: ListView.builder(
          itemCount: wetherStatus.length,
          itemBuilder: (context, index) => Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF5130A7),
                  Color(0xFF5130A7),
                  Color(0xFF8F6AC6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 120,
                ),
                Text(
                  loc,
                  style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                Text(
                  'Updated: ${DateFormat('hh:mm a').format(DateTime.now())}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(
                        'https://openweathermap.org/img/wn/${weatherType[index].icon}@2x.png'),
                    Text(
                      '${(wetherStatus[index].temp - 273.15).toStringAsPrecision(2)}°',
                      style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Column(
                      children: [
                        Text(
                          'max: ${(wetherStatus[index].tempMax - 273.15).toStringAsPrecision(2)}°',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                        Text(
                          'min: ${(wetherStatus[index].tempMin - 273.15).toStringAsPrecision(2)}°',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Text(
                  weatherType[index].description.toCapitalized(),
                  style: const TextStyle(fontSize: 23, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
