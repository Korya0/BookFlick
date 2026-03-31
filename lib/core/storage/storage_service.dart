import 'package:hive_flutter/hive_flutter.dart';

abstract class IStorageService {
  Future<void> init();

  T? read<T>(String key, {String? boxName});
  Future<void> write<T>(String key, T value, {String? boxName});
  Future<void> delete(dynamic key, {String? boxName});
  Future<void> clear({String? boxName});

  Future<num?> add<T>(T value, {String? boxName});
  List<T> getAll<T>({String? boxName});
  Map<dynamic, T> getMap<T>({String? boxName});
  Stream<BoxEvent> watch({String? boxName});
}
