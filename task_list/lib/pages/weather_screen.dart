import 'package:flutter/material.dart';
import '../widgets/weather_panel.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Погода'),
      ),
      body: const Center(
        child: WeatherPanel(),
      ),
    );
  }
}
