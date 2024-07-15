abstract class CacheConsumer {
  //get
  dynamic getData({required String key});

  //save
  dynamic saveData({
    required String key,
    required dynamic value,
  });

  //clear
  dynamic clearData();
  dynamic clearValue({required String key});
}
