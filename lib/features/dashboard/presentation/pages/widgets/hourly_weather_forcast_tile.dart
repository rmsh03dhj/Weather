import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/features/dashboard/domain/entities/weather.dart';
import 'package:weather/features/dashboard/presentation/pages/widgets/value_tile.dart';

class HourlyWeatherForcastTile extends StatelessWidget {
  const HourlyWeatherForcastTile({
    Key key,
    @required this.weathers,
  }) : super(key: key);

  final List<Weather> weathers;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
                child: Card(
              child: Container(
                decoration: new BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ValueTile(
                    DateFormat('E, h a')
                        .format(DateTime.fromMillisecondsSinceEpoch(item.time * 1000)),
                    '${item.temperature.celsius.round()} \u2103',
                    iconData: item.getIconData(),
                  ),
                ),
              ),
            )),
          );
        },
      ),
    );
  }
}
