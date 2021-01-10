import 'package:weather/core/services/navigation_service.dart';
import 'package:weather/core/services/remote_config_service.dart';
import 'package:weather/features/app_start/domain/usecases/check_for_authentication_use_case.dart';
import 'package:weather/features/dashboard/data/repositories/weather_repository_impl.dart';
import 'package:weather/features/dashboard/domain/usecases/fetch_weather__for_given_city_use_case.dart';
import 'package:weather/features/dashboard/domain/usecases/fetch_weather_for_given_coordinates_use_case.dart';
import 'package:weather/features/dashboard/domain/usecases/fetch_weather_for_user_current_location_use_case.dart';
import 'package:weather/features/registration_or_login/data/repositories/user_repository_impl.dart';
import 'package:weather/features/registration_or_login/domain/repositories/user_repository.dart';
import 'package:weather/features/app_start/presentation/bloc/app_start_bloc.dart';
import 'package:weather/features/dashboard/domain/repositories/weather_repository.dart';
import 'package:weather/features/dashboard/presentation/bloc/weather_bloc.dart';
import 'package:weather/features/registration_or_login/domain/usecases/sign_in_use_case.dart';
import 'package:weather/features/registration_or_login/domain/usecases/sign_up_use_case.dart';
import 'package:weather/features/registration_or_login/presentation/bloc/registration_or_login_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/core/services/weather_api_client.dart';

import 'location_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  ///blocs
  sl.registerFactory(() => AppStartBloc());
  sl.registerFactory(() => RegistrationOrLoginBloc());
  sl.registerFactory(() => WeatherBloc());

  ///use cases
  sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCaseImpl());
  sl.registerLazySingleton<CheckForAuthenticationUseCase>(
      () => CheckForAuthenticationUseCaseImpl());
  sl.registerLazySingleton<SignInUseCase>(() => SignInUseCaseImpl());
  sl.registerLazySingleton<FetchWeatherForGivenCityUseCase>(
      () => FetchWeatherForGivenCityUseCaseImpl());
  sl.registerLazySingleton<FetchWeatherForGivenLocationUseCase>(
      () => FetchWeatherForGivenLocationUseCaseImpl());
  sl.registerLazySingleton<FetchWeatherForCurrentLocationUseCase>(
      () => FetchWeatherForCurrentLocationUseCaseImpl());

  ///repositories
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl());

  ///services
  sl.registerLazySingleton(() => NavigationService());
  sl.registerLazySingleton(() => LocationService());
  sl.registerFactory(() => WeatherApiClient());
  var remoteConfigService = await RemoteConfigService.getInstance();
  sl.registerSingleton(remoteConfigService);
}
