import 'package:bookna_app/core/storage/storage_keys.dart';
import 'package:bookna_app/core/storage/storage_service.dart';
import 'package:bookna_app/features/catalog/domain/entities/book.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStorageService implements IStorageService {
  final String _defaultBoxName = StorageKeys.favoritesBox;

  @override
  Future<void> init() async {
    await Hive.initFlutter();

    // Register Adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(BookAdapter());
    }

    // Open initial boxes
    await Hive.openBox<Book>(_defaultBoxName);
  }

  Box<T> _getBox<T>(String? boxName) {
    final name = boxName ?? _defaultBoxName;
    return Hive.box<T>(name);
  }

  @override
  T? read<T>(String key, {String? boxName}) {
    return _getBox<T>(boxName).get(key);
  }

  @override
  Future<void> write<T>(String key, T value, {String? boxName}) async {
    await _getBox<T>(boxName).put(key, value);
  }

  @override
  Future<void> delete(dynamic key, {String? boxName}) async {
    await _getBox(boxName).delete(key);
  }

  @override
  Future<num?> add<T>(T value, {String? boxName}) async {
    // Return key assigned by Hive
    return await _getBox<T>(boxName).add(value) as num?;
  }

  @override
  Future<void> clear({String? boxName}) async {
    await _getBox(boxName).clear();
  }

  @override
  List<T> getAll<T>({String? boxName}) {
    return _getBox<T>(boxName).values.toList();
  }

  @override
  Map<dynamic, T> getMap<T>({String? boxName}) {
    return _getBox<T>(boxName).toMap();
  }

  @override
  Stream<BoxEvent> watch({String? boxName}) {
    return _getBox(boxName).watch();
  }
}
