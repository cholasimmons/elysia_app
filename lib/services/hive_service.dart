import 'package:elysia_app/constants/constants.dart';
import 'package:elysia_app/models/province_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();

  factory HiveService() {
    return _instance;
  }

  HiveService._internal();

  /// Opens a box if it isn't already opened.
  Future<Box<T>> openBox<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox<T>(boxName);
    }
    return Hive.box<T>(boxName);
  }

  /// Stores data in the specified box.
  Future<void> putData<T>(String boxName, String key, T data) async {
    final dataBox = await openBox<T>(boxName);
    final timestampBox = await openBox<DateTime>('timestampBox');

    // Save the data
    await dataBox.put(key, data);

    // Update the timestamp
    await timestampBox.put('$boxName-$key', DateTime.now());
  }

  /// Retrieves data from the specified box.
  Future<T?> getData<T>(String boxName, String key) async {
    final box = await openBox<T>(boxName);
    return box.get(key);
  }

  /// Deletes data from the specified box.
  Future<void> deleteData<T>(String boxName, String key) async {
    final box = await openBox<T>(boxName);
    await box.delete(key);
  }

  /// Checks if data is stale based on the last update timestamp.
  Future<bool> isDataStale(String boxName, String key) async {
    final timestampBox = await openBox<DateTime>('timestampBox');
    final lastUpdate = timestampBox.get('$boxName-$key');
    if (lastUpdate == null) return true;

    final now = DateTime.now();
    return now.difference(lastUpdate) > const Duration(minutes: AppConstants.staleDuration);
  }

  /// Updates the timestamp for a specific box and key.
  Future<void> updateTimestamp(String boxName, String key) async {
    final timestampBox = await openBox<DateTime>('timestampBox');
    await timestampBox.put('$boxName-$key', DateTime.now());
  }
}