import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'cache_consumer.dart';

class SecureCacheHelper extends CacheConsumer {
  final FlutterSecureStorage sharedPref;


  SecureCacheHelper({required this.sharedPref});
  @override
  Future<void> clearData() async {
    await sharedPref.deleteAll();
  }

  @override
  Future<String?> getData({required String key}) async {
    return await sharedPref.read(key: key);
  }

  @override
  Future<void> saveData({required String key, required value}) async {
    await sharedPref.write(key: key, value: value);
  }

  @override
  Future<void> clearValue({required String key}) async {
    sharedPref.delete(key: key);
  }
}
