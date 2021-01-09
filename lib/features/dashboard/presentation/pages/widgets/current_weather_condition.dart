import 'package:flutter/material.dart';
import 'package:weather/features/dashboard/domain/entities/weather.dart';
import 'package:weather/features/dashboard/presentation/pages/widgets/value_tile.dart';

class CurrentWeatherCondition extends StatelessWidget {
  final Weather weather;
  const CurrentWeatherCondition({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          weather.getIconData(),
          size: 70,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '${this.weather.temperature.celsius.round()}°',
          style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.w100,
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          ValueTile("max",
              '${this.weather.maxTemperature.celsius.round()}°'),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Center(
                child: Container(
              width: 1,
              height: 30,
              color:
                  Theme.of(context).disabledColor,
            )),
          ),
          ValueTile("min",
              '${this.weather.minTemperature.celsius.round()}°'),
        ]),
      ],
    );
  }
}
