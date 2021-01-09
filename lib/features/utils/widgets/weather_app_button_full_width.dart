import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/features/utils/widgets/weather_app_button.dart';

class WeatherAppButtonFullWidth extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final Color textColor;
  final Color borderColor;
  final VoidCallback onPressed;
  final bool showCircularProgressIndicator;
  final bool showTickSymbol;

  const WeatherAppButtonFullWidth(
      {Key key,
      this.text,
      this.onPressed,
      this.buttonColor,
      this.textColor,
      this.showCircularProgressIndicator = false,
      this.showTickSymbol = false,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: WeatherAppButton(
          text: text,
          buttonColor: buttonColor,
          textColor: textColor,
          borderColor: borderColor,
          onPressed: onPressed,
          showCircularProgressIndicator: showCircularProgressIndicator,
          showTickSymbol: showTickSymbol,
        ),
      ),
    );
  }
}
