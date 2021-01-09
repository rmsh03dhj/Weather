import 'package:firebase_remote_config/firebase_remote_config.dart';

const String _weatherApiKey = "weatherApiKey";

class RemoteConfigService {
  final RemoteConfig _remoteConfig;

  static RemoteConfigService _instance;
  static Future<RemoteConfigService> getInstance() async {
    if (_instance == null) {
      _instance = RemoteConfigService(
        remoteConfig: await RemoteConfig.instance,
      );
    }

    return _instance;
  }

  RemoteConfigService({RemoteConfig remoteConfig}) : _remoteConfig = remoteConfig;

  String get weatherApiKey => _remoteConfig.getString(_weatherApiKey);

  Future initialise() async {
    try {
      await _fetchAndActivate();
    } catch (e) {
      throw (e);
    }
  }

  Future _fetchAndActivate() async {
    await _remoteConfig.fetch();
    await _remoteConfig.activateFetched();
  }
}
