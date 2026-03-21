import 'package:bookna_app/core/resources/app_strings.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoriteCubit extends Cubit<List<Book>> {
  final Box<Book> _favoritesBox;

  FavoriteCubit()
    : _favoritesBox = Hive.box<Book>(AppStrings.favoritesBox),
      super([]) {
    loadFavorites();
    _setupListener();
  }

  void loadFavorites() {
    final favorites = _favoritesBox.values.toList();
    emit(favorites);
  }

  void _setupListener() {
    _favoritesBox.watch().listen((event) {
      loadFavorites();
    });
  }

  Future<void> addToFavorites(Book book) async {
    if (!isFavorite(book)) {
      await _favoritesBox.add(book);
    }
  }

  Future<void> removeFromFavorites(Book book) async {
    final key = _getKeyForBook(book);
    if (key != null) {
      await _favoritesBox.delete(key);
    }
  }

  Future<void> clearAllFavorites() async {
    await _favoritesBox.clear();
  }

  bool isFavorite(Book book) {
    return state.any((b) => b.bookId == book.bookId);
  }

  int? _getKeyForBook(Book book) {
    final bookMap = _favoritesBox.toMap();
    for (final entry in bookMap.entries) {
      if (entry.value.bookId == book.bookId) {
        return entry.key as int;
      }
    }
    return null;
  }
}
