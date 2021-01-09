import 'package:weather/core/services/service_locator.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/services/remote_config_service.dart';
import 'package:weather/weather_app.dart';

import 'core/services/location_service.dart';
import 'core/services/service_locator.dart';
import 'core/simple_bloc_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp();
  await sl<RemoteConfigService>().initialise();
  await sl<LocationService>().requestLocationAccess();
  Bloc.observer = SimpleBlocDelegate();

  runApp(WeatherApp());
}
