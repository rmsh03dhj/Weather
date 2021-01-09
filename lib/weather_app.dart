import 'package:weather/features/dashboard/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/registration_or_login/presentation/bloc/registration_or_login_bloc.dart';
import 'package:weather/features/registration_or_login/presentation/pages/register_or_login_page_wrapper.dart';

import 'package:weather/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/weather_app_routes.dart';
import 'core/services/service_locator.dart';
import 'core/services/navigation_service.dart';
import 'features/app_start/presentation/bloc/app_start_bloc.dart';
import 'features/app_start/presentation/bloc/app_start_event.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';

class WeatherApp extends StatefulWidget {
  WeatherApp({Key key}) : super(key: key);

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppStartBloc>(
      create: (context) => sl<AppStartBloc>()..add(CheckForAuthentication()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<RegistrationOrLoginBloc>(
            create: (context) => sl<RegistrationOrLoginBloc>(),
          ),
          BlocProvider<WeatherBloc>(
            create: (context) => sl<WeatherBloc>(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: sl<NavigationService>().navigationKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          routes: _registerRoutes(),
          home: SplashScreen(),
        ),
      ),
    );
  }
}

Map<String, WidgetBuilder> _registerRoutes() {
  return <String, WidgetBuilder>{
    WeatherAppRoutes.dashboard: (context) => WeatherScreen(),
    WeatherAppRoutes.signUpOrSignIn: (context) => _buildSignInWithEmailBloc(),
  };
}

BlocProvider<RegistrationOrLoginBloc> _buildSignInWithEmailBloc() {
  return BlocProvider<RegistrationOrLoginBloc>(
    create: (context) => sl<RegistrationOrLoginBloc>(),
    child: RegistrationOrLoginPageWrapper(),
  );
}
