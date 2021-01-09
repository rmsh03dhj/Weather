import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather/core/routes/weather_app_routes.dart';
import 'package:weather/core/services/service_locator.dart';
import 'package:weather/core/services/navigation_service.dart';
import 'package:weather/features/app_start/presentation/bloc/app_start_bloc.dart';
import 'package:weather/features/app_start/presentation/bloc/app_start_event.dart';
import 'package:weather/features/dashboard/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/dashboard/presentation/bloc/weather_event.dart';
import 'package:weather/features/dashboard/presentation/bloc/weather_state.dart';
import 'package:weather/features/dashboard/presentation/pages/widgets/current_weather_detailed_tile.dart';
import 'package:weather/features/utils/constants/strings.dart';
import 'package:weather/features/utils/widgets/weather_app_button.dart';
import 'package:weather/features/utils/widgets/weather_app_form_builder_text_field.dart';

class WeatherScreen extends StatefulWidget {
  final Position position;

  const WeatherScreen({Key key, this.position}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final navigationService = sl<NavigationService>();
  TextEditingController cityNameController = TextEditingController();
  FocusNode cityNameFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
                  style: TextStyle(color: Theme.of(context).disabledColor, fontSize: 14),
                ),
              )
            ],
          ),
        ),
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Drawer(
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              DrawerHeader(
                  child: Image.asset(
                "assets/login_icon.png",
                scale: 3,
              )),
              ListTile(
                title: Text(changeCity),
                onTap: () {
                  Navigator.pop(context);
                  _showCityChangeDialog();
                },
              ),
              ListTile(
                title: Text(logout),
                onTap: () {
                  BlocProvider.of<AppStartBloc>(context)..add(LoggedOut());
                  navigationService.navigateToAndRemoveUntil(WeatherAppRoutes.signUpOrSignIn);
                },
              ),
            ]),
          ),
        ),
        body: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state is WeatherLoaded) {
            return SingleChildScrollView(
              child: CurrentWeatherDetailedTile(
                weather: state.weather,
              ),
            );
          } else if (state is WeatherError || state is WeatherEmpty) {
            String errorText = 'There was an error fetching weather data';
            if (state is WeatherError) {
                errorText = state.errorMessage;
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.error_outline,
                    color: Colors.redAccent,
                    size: 24,
                  ),
                  FlatButton(
                    child: Text(
                      "Try Again",
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                    onPressed: _showCityChangeDialog,
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
  }

  void _showCityChangeDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text(changeCity)),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                child: WeatherAppButton(
                  text: okButton,
                  onPressed: () {
                    BlocProvider.of<WeatherBloc>(context)
                      ..add(FetchWeather(cityName: cityNameController.text));
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
            content: WeatherAppFormBuilderTextField(
              attribute: cityName,
              label: cityName,
              controller: cityNameController,
            ),
          );
        });
  }
}