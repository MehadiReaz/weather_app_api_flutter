class Weather {
  final double temp;
  final double tempMin;
  final double tempMax;
  Weather(
    this.temp,
    this.tempMax,
    this.tempMin,
  );

  factory Weather.toJson(Map<String, dynamic> e) {
    return Weather(
      e["temp"],
      e['temp_max'],
      e['temp_min'],
    );
  }
}

class WeatherType {
  final String description;
  final String icon;

  WeatherType(this.description, this.icon);

  factory WeatherType.toJson(Map<String, dynamic> e) {
    return WeatherType(e["description"], e["icon"]);
  }
}
