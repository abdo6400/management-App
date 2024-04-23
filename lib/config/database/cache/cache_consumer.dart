abstract class CacheConsumer {
  //get
  dynamic getIntData({required String key});
  dynamic getStringData({required String key});
  dynamic getBoolData({required String key});
  dynamic getDoubleData({required String key});
  //save
  dynamic saveData({
    required String key,
    required dynamic value,
  });

  //clear
  dynamic clearData();
  dynamic clearValue({required String key});
}
