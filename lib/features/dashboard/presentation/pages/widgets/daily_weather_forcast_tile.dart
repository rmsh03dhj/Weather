import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/features/dashboard/domain/entities/weather.dart';
import 'package:weather/features/dashboard/presentation/pages/widgets/value_tile.dart';

class DailyWeatherForcastTile extends StatelessWidget {
  const DailyWeatherForcastTile({
    Key key,
    @required this.weathers,
  }) : super(key: key);

  final List<Weather> weathers;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: this.weathers.length,
        separatorBuilder: (context, index) => Divider(
          height: 100,
          color: Theme.of(context).disabledColor,
        ),
        padding: EdgeInsets.only(left: 10, right: 10),
        itemBuilder: (context, index) {
          final item = this.weathers[index];
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Center(
                child: ValueTile(
              DateFormat('E, ha').format(DateTime.fromMillisecondsSinceEpoch(item.time * 1000)),
              '${item.temperature.celsius.round()}°',
              iconData: item.getIconData(),
            )),
          );
        },
      ),
    );
  }
}
