import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import '../services/location.dart';
import '../entitys/weather.dart';

class WeatherPanel extends StatefulWidget {
  const WeatherPanel({Key? key}) : super(key: key);

  @override
  State<WeatherPanel> createState() => _WeatherPanelState();
}

class _WeatherPanelState extends State<WeatherPanel> {
  late Position position;

  static final textStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.grey[700],
    fontSize: 30,
  );
  final Map<String, String> weatherCondition = {
    'clear': 'ясно',
    'partly-cloudy': 'малооблачно',
    'cloudy': 'облачно с прояснениями',
    'overcast': 'пасмурно',
    'drizzle': 'морось',
    'light-rain': 'дождь',
    'moderate-rain': ' умеренно сильный дождь',
    'heavy-rain': 'сильный дождь',
    'continuous-heavy-rain': 'длительный сильный дождь',
    'showers': 'ливень',
    'wet-snow': 'дождь со снегом',
    'light-snow': 'небольшой снег',
    'snow-showers': 'снегопад',
    'hail': 'град',
    'thunderstorm': 'гроза',
    'thunderstorm-with-rain': 'дождь с грозой',
    'thunderstorm-with-hail': 'гроза с градом',
  };

  Future<Weather> getWeather() async {
    late Position position;
    try {
      position = await Location.getLocation();
    } catch (error) {
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    Uri url = Uri.parse(
        'https://api.weather.yandex.ru/v2/forecast?lat=${position.latitude}&lon=${position.longitude}&lang=ru_RU');

    var response = await http.get(url, headers: {
      'X-Yandex-API-Key': '67c1809e-04f0-4981-add6-aa333084b5f2',
    });
    var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    weatherCondition.containsKey(jsonData['fact']['condition']);

    int temp = jsonData['fact']['temp'];
    int tempFeels = jsonData['fact']['feels_like'];
    String locality = jsonData['geo_object']['locality']['name'];
    String condition = jsonData['fact']['condition'];
    String icon = jsonData['fact']['icon'];
    Weather weather = Weather(temp, tempFeels, locality, weatherCondition[condition]!, icon);
    return weather;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getWeather(),
      builder: (context, AsyncSnapshot<Weather> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: Text(
              'Загрузка...',
              style: TextStyle(fontSize: 20),
            ),
          );
        } else {
          Weather data = snapshot.requireData;
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 100,
                ),
              ),
              Text(
                data.locality,
                style: textStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                  Text(
                    (data.temp > 0 ? '+${data.temp}°' : '${data.temp}°'),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      fontSize: 50,
                      height: 1.2
                    ),
                  ),
                  SizedBox(
                    height: 50, width: 50,
                    child: SvgPicture.network(
                      'https://yastatic.net/weather/i/icons/funky/dark/${data.icon}.svg',
                    ),
                  )
                ],
              ),
              Text(
                data.condition,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                  fontSize: 20,
                ),
              ),
              Text(
                'Ощущается как: ${data.temp > 0 ? '+${data.tempFeels}°' : '${data.tempFeels}°'}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                  fontSize: 20,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
