import 'package:convenient_way/config/map_config.dart';

import 'env_config.dart';
import 'environment.dart';

class BuildConfig {
  late final Environment environment;
  late final EnvConfig config;
  late final MapConfig mapConfig;
  bool _lock = false;

  static final BuildConfig instance = BuildConfig._internal();

  BuildConfig._internal();

  factory BuildConfig.instantiate(
      {required Environment envType,
      required EnvConfig envConfig,
      required MapConfig mapConfig}) {
    if (instance._lock) return instance;

    instance.environment = envType;
    instance.config = envConfig;
    instance.mapConfig = mapConfig;
    instance._lock = true;

    return instance;
  }
}
