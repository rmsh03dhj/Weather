import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class WeatherDashboardPage extends StatefulWidget {
  final User user;

  const WeatherDashboardPage({Key key, this.user}) : super(key: key);

  @override
  _WeatherDashboardPageState createState() => _WeatherDashboardPageState();
}

class _WeatherDashboardPageState extends State<WeatherDashboardPage> {
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
                child: Column(
                  children: [
                    Container(
                      height: 72,
                      width: 72,
                      child: Image.asset(
                        "assets/login_icon.png",
                        scale: 3,
                      ),
                    ),
                    Container(
                      height: 24,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Welcome",
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    Container(
                      height: 4,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.user.email,
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text(changeCityText),
                onTap: () {
                  Navigator.pop(context);
                  _showCityChangeDialog();
                },
              ),
              ListTile(
                title: Text(logoutText),
                leading: Icon(Icons.logout),
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
            title: Center(
              child: Text(
                changeCityText,
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                child: WeatherAppButton(
                  text: okButtonText,
                  onPressed: () {
                    if (cityNameController.text.isEmpty) {
                      BlocProvider.of<WeatherBloc>(context)..add(FetchWeatherForCurrentLocation());
                    } else {
                      BlocProvider.of<WeatherBloc>(context)
                        ..add(FetchWeatherForGivenCity(cityName: cityNameController.text));
                      FocusScope.of(context).unfocus();
                    }
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
            content: WeatherAppFormBuilderTextField(
              attribute: cityNameText,
              label: cityNameText,
              controller: cityNameController,
            ),
          );
        });
  }
}
