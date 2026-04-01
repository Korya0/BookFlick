import 'package:bookna_app/core/storage/storage_keys.dart';
import 'package:bookna_app/core/storage/storage_service.dart';
import 'package:bookna_app/core/utils/logging/app_logger.dart';
import 'package:bookna_app/features/catalog/domain/entities/book.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveStorageService implements IStorageService {
  final String _defaultBoxName = StorageKeys.favoritesBox;

  @override
  Future<void> init() async {
    AppLogger.info('📦 Initializing Hive Storage...');
    await Hive.initFlutter();

    // Register Adapters
    if (!Hive.isAdapterRegistered(0)) {
      AppLogger.debug('🔗 Registering BookAdapter');
      Hive.registerAdapter(BookAdapter());
    }

    // Open initial boxes
    AppLogger.debug('📂 Opening box: $_defaultBoxName');
    await Hive.openBox<Book>(_defaultBoxName);
    AppLogger.info('✅ Hive Storage initialized');
  }

  Box<T> _getBox<T>(String? boxName) {
    final name = boxName ?? _defaultBoxName;
    return Hive.box<T>(name);
  }

  @override
  T? read<T>(String key, {String? boxName}) {
    AppLogger.debug('📖 Reading from Storage: [Box: ${boxName ?? _defaultBoxName}] Key: $key');
    return _getBox<T>(boxName).get(key);
  }

  @override
  Future<void> write<T>(String key, T value, {String? boxName}) async {
    AppLogger.debug('✍️ Writing to Storage: [Box: ${boxName ?? _defaultBoxName}] Key: $key');
    await _getBox<T>(boxName).put(key, value);
  }

  @override
  Future<void> delete(dynamic key, {String? boxName}) async {
    AppLogger.debug('🗑️ Deleting from Storage: [Box: ${boxName ?? _defaultBoxName}] Key: $key');
    await _getBox(boxName).delete(key);
  }

  @override
  Future<num?> add<T>(T value, {String? boxName}) async {
    AppLogger.debug('➕ Adding to Storage: [Box: ${boxName ?? _defaultBoxName}]');
    // Return key assigned by Hive
    return await _getBox<T>(boxName).add(value) as num?;
  }

  @override
  Future<void> clear({String? boxName}) async {
    AppLogger.warning('🧹 Clearing Storage: [Box: ${boxName ?? _defaultBoxName}]');
    await _getBox(boxName).clear();
  }

  @override
  List<T> getAll<T>({String? boxName}) {
    AppLogger.debug('📑 Getting all from Storage: [Box: ${boxName ?? _defaultBoxName}]');
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
