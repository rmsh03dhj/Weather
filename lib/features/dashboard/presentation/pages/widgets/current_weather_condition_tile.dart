import 'package:flutter/material.dart';
import 'package:weather/features/dashboard/domain/entities/weather.dart';
import 'package:weather/features/dashboard/presentation/pages/widgets/value_tile.dart';
import 'package:intl/intl.dart';
import 'package:weather/features/dashboard/presentation/pages/widgets/vertical_divider_bar.dart';
import 'package:weather_icons/weather_icons.dart';

class CurrentWeatherConditionTile extends StatelessWidget {
  final Weather weather;
  const CurrentWeatherConditionTile({Key key, this.weather}) : super(key: key);

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
          '${this.weather.temperature.celsius.round()} \u2103',
          style: TextStyle(
            fontSize: 100,
            fontWeight: FontWeight.w100,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ValueTile('${this.weather.maxTemperature.celsius.round()} \u2103', label: "max"),
            VerticalDividerBar(),
            ValueTile(
              '${this.weather.feelsLike.celsius.round()}  \u2103',
              label: "Feels like",
            ),
            VerticalDividerBar(),

            ValueTile('${this.weather.minTemperature.celsius.round()} \u2103', label: "min"),
          ],
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueTile(
                DateFormat('h:m a')
                    .format(DateTime.fromMillisecondsSinceEpoch(this.weather.sunrise * 1000)),
                iconData: WeatherIcons.sunrise,
              ),
              ValueTile(
                DateFormat('h:m a')
                    .format(DateTime.fromMillisecondsSinceEpoch(this.weather.sunset * 1000)),
                iconData: WeatherIcons.sunset,
              ),
            ],
          ),
        )
      ],
    );
  }
}
