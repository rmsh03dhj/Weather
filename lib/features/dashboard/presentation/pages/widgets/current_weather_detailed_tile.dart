import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/features/dashboard/domain/entities/weather.dart';
import 'package:weather/features/dashboard/presentation/pages/widgets/current_weather_condition.dart';
import 'package:weather/features/dashboard/presentation/pages/widgets/daily_weather_forcast_tile.dart';
import 'package:weather/features/dashboard/presentation/pages/widgets/value_tile.dart';


class CurrentWeatherDetailedTile extends StatelessWidget {
  final Weather weather;

  CurrentWeatherDetailedTile({this.weather}) : assert(weather != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(height: 72,),
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
            height: 300,
            child: CurrentWeatherCondition(
              weather: weather,
            ),
          ),
          Padding(
            child: Divider(),
            padding: EdgeInsets.all(10),
          ),
          DailyWeatherForcastTile(weathers: weather.forecast),
          Padding(
            child: Divider(
              color: Theme.of(context).accentColor.withAlpha(50),
            ),
            padding: EdgeInsets.all(10),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            ValueTile("wind speed", '${this.weather.windSpeed} m/s'),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: Container(
                width: 1,
                height: 30,
                color: Theme.of(context).accentColor.withAlpha(50),
              )),
            ),
            ValueTile(
                "sunrise",
                DateFormat('h:m a')
                    .format(DateTime.fromMillisecondsSinceEpoch(this.weather.sunrise * 1000))),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: Container(
                width: 1,
                height: 30,
                color: Theme.of(context).accentColor.withAlpha(50),
              )),
            ),
            ValueTile(
                "sunset",
                DateFormat('h:m a')
                    .format(DateTime.fromMillisecondsSinceEpoch(this.weather.sunset * 1000))),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: Container(
                width: 1,
                height: 30,
                color: Theme.of(context).accentColor.withAlpha(50),
              )),
            ),
            ValueTile("humidity", '${this.weather.humidity}%'),
          ]),
        ],
      ),
    );
  }
}
