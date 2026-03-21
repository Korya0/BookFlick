// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookAdapter extends TypeAdapter<Book> {
  @override
  final int typeId = 0;

  @override
  Book read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Book(
      bookId: fields[1] as String?,
      title: fields[2] as String?,
      authors: (fields[3] as List?)?.cast<String>(),
      publishedDate: fields[4] as String?,
      description: fields[5] as String?,
      pageCount: fields[6] as num?,
      price: fields[7] as num?,
      averageRating: fields[8] as num?,
      ratingsCount: fields[9] as num?,
      thumbnail: fields[10] as String,
      categories: (fields[11] as List?)?.cast<String>(),
      previewLink: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer
      ..writeByte(12)
      ..writeByte(1)
      ..write(obj.bookId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.authors)
      ..writeByte(4)
      ..write(obj.publishedDate)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.pageCount)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.averageRating)
      ..writeByte(9)
      ..write(obj.ratingsCount)
      ..writeByte(10)
      ..write(obj.thumbnail)
      ..writeByte(11)
      ..write(obj.categories)
      ..writeByte(12)
      ..write(obj.previewLink);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
