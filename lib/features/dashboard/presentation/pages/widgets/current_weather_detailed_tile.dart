import 'package:flutter/material.dart';
import 'package:weather/features/dashboard/domain/entities/weather.dart';
import 'package:weather/features/dashboard/presentation/pages/widgets/current_weather_condition_tile.dart';
import 'package:weather/features/dashboard/presentation/pages/widgets/value_tile.dart';
import 'package:weather/features/dashboard/presentation/pages/widgets/vertical_divider_bar.dart';

import 'hourly_weather_forecast_tile.dart';

class CurrentWeatherDetailedTile extends StatelessWidget {
  final Weather weather;

  CurrentWeatherDetailedTile({this.weather}) : assert(weather != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 60,
          ),
          Text(
            this.weather.cityName.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w900,
              letterSpacing: 5,
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            this.weather.description.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w100,
              letterSpacing: 5,
              fontSize: 15,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 330,
            child: CurrentWeatherConditionTile(
              weather: weather,
            ),
          ),
          Padding(
            child: Divider(),
            padding: EdgeInsets.all(10),
          ),
          HourlyWeatherForecastTile(weathers: weather.forecast),
          Padding(
            child: Divider(
              color: Theme.of(context).accentColor.withAlpha(50),
            ),
            padding: EdgeInsets.all(10),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            ValueTile(
              '${this.weather.windSpeed} m/s',
              label: "wind speed",
            ),
            VerticalDividerBar(),
            ValueTile(
              '${this.weather.pressure} hPa',
              label: "pressure",
            ),
            VerticalDividerBar(),
            ValueTile(
              '${this.weather.humidity} %',
              label: "humidity",
            )
          ]),
        ],
      ),
    );
  }
}
