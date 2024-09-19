class WeatherDto {
  String? date;
  String? sunrise;
  String? sunset;
  String? windSpeed;
  String? pressure;
  String? visibility;
  String? temperature;
  String? chancesOfRain;
  String? humidity;
  String? uvIndex;

  WeatherDto({
    this.date,
    this.sunrise,
    this.sunset,
    this.windSpeed,
    this.pressure,
    this.visibility,
    this.temperature,
    this.chancesOfRain,
    this.humidity,
    this.uvIndex,
  });


  factory WeatherDto.fromJson(Map<String, dynamic> json) {
  return WeatherDto(
    date: json['date'] as String?,
    sunrise: json['sunrise'] as String?,
    sunset: json['sunset'] as String?,
    windSpeed: json['windspeed'] as String?,
    pressure: json['pressure'] as String?,
    visibility: json['visibility'] as String?,
    temperature: json['temperature'] as String?,
    chancesOfRain: json['chances_of_rain'] as String?,
    humidity: json['humidity'] as String?,
    uvIndex: json['uv_index'] as String?,
  );
}


}
