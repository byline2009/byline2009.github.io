import 'package:bloc_login/data_layer/provider/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'logger.dart';
import 'package:package_info/package_info.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

GetIt locator = GetIt.instance;

class LocatorInjector {
  static Logger _log = getLogger('LocatorInjector');
  static Future<void> setupLocator() async {
    _log.d('Initializing  Service');
    final packageInfo = await PackageInfo.fromPlatform();
    final prefs = await SharedPreferences.getInstance();
    locator.registerLazySingleton(() => Api());
    locator.registerSingleton(packageInfo);
    locator.registerSingleton(prefs);
  }
}
