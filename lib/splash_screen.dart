import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:weather/core/routes/weather_app_routes.dart';
import 'package:weather/features/dashboard/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/dashboard/presentation/bloc/weather_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/service_locator.dart';
import 'core/services/navigation_service.dart';
import 'features/app_start/presentation/bloc/app_start_bloc.dart';
import 'features/app_start/presentation/bloc/app_start_state.dart';
import 'features/utils/constants/strings.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final navigator = sl<NavigationService>();
  Position position;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppStartBloc, AppStartState>(
      listener: (context, state) {
        if (state is Unauthenticated || state is Uninitialized) {
          Timer(
            Duration(seconds: 5),
            () => navigator.navigateToAndReplace(WeatherAppRoutes.signUpOrSignIn,
                arguments: position),
          );
        }
        if (state is Authenticated) {
          Timer(Duration(seconds: 5), () async {
            BlocProvider.of<WeatherBloc>(context)
              ..add(FetchWeather(
                longitude: position.longitude,
                latitude: position.latitude,
              ));
            navigator.navigateToAndRemoveUntil(WeatherAppRoutes.dashboard);
          });
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150,
              ),
              Text(
                weatherApp.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5,
                  fontSize: 25,
                ),
              ),
              Container(
                height: 100,
              ),
              Image.asset(
                "assets/weather_animation.gif",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
