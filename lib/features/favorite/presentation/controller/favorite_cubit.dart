import 'package:bookna_app/core/di/di_locator.dart';
import 'package:bookna_app/core/storage/storage_keys.dart';
import 'package:bookna_app/core/storage/storage_service.dart';
import 'package:bookna_app/features/catalog/domain/entities/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<List<Book>> {
  final IStorageService _storageService;

  FavoriteCubit()
    : _storageService = getIt.get<IStorageService>(),
      super([]) {
    loadFavorites();
    _setupListener();
  }

  void loadFavorites() {
    final favorites = _storageService.getAll<Book>(
      boxName: StorageKeys.favoritesBox,
    );
    emit(favorites);
  }

  void _setupListener() {
    _storageService.watch(boxName: StorageKeys.favoritesBox).listen((event) {
      loadFavorites();
    });
  }

  Future<void> addToFavorites(Book book) async {
    if (!isFavorite(book)) {
      await _storageService.add(book, boxName: StorageKeys.favoritesBox);
    }
  }

  Future<void> removeFromFavorites(Book book) async {
    final key = _getKeyForBook(book);
    if (key != null) {
      await _storageService.delete(key, boxName: StorageKeys.favoritesBox);
    }
  }

  Future<void> clearAllFavorites() async {
    await _storageService.clear(boxName: StorageKeys.favoritesBox);
  }

  bool isFavorite(Book book) {
    return state.any((b) => b.bookId == book.bookId);
  }

  dynamic _getKeyForBook(Book book) {
    final bookMap = _storageService.getMap<Book>(
      boxName: StorageKeys.favoritesBox,
    );
    for (final entry in bookMap.entries) {
      if (entry.value.bookId == book.bookId) {
        return entry.key;
      }
    }
    return null;
  }
}
