import 'package:bookna_app/core/data/network/api_constants.dart';
import 'package:bookna_app/features/books/domain/entities/book.dart';
import 'access_info.dart';
import 'sale_info.dart';
import 'search_info.dart';
import 'volume_info.dart';

class BookModel extends Book {
  String? kind;
  String? id;
  String? etag;
  String? selfLink;
  VolumeInfo? volumeInfo;
  SaleInfo? saleInfo;
  AccessInfo? accessInfo;
  SearchInfo? searchInfo;

  BookModel({
    this.kind,
    this.id,
    this.etag,
    this.selfLink,
    this.volumeInfo,
    this.saleInfo,
    this.accessInfo,
    this.searchInfo,
  }) : super(
         bookId: id,
         title: volumeInfo?.title,
         authors: volumeInfo?.authors,
         publishedDate: volumeInfo?.publishedDate,
         description: volumeInfo?.description,
         pageCount: volumeInfo?.pageCount,
         price: saleInfo?.retailPrice?.amount ?? 0,
         averageRating: volumeInfo?.averageRating ?? 0,
         ratingsCount: volumeInfo?.ratingsCount ?? 0,
         thumbnail:
             volumeInfo?.imageLinks?.thumbnail ?? ApiConstants.placeholder,
         categories: volumeInfo?.categories,
         previewLink: volumeInfo?.previewLink,
       );

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
    kind: json['kind'] as String?,
    id: json['id'] as String?,
    etag: json['etag'] as String?,
    selfLink: json['selfLink'] as String?,
    volumeInfo:
        json['volumeInfo'] == null
            ? null
            : VolumeInfo.fromJson(json['volumeInfo'] as Map<String, dynamic>),
    saleInfo:
        json['saleInfo'] == null
            ? null
            : SaleInfo.fromJson(json['saleInfo'] as Map<String, dynamic>),
    accessInfo:
        json['accessInfo'] == null
            ? null
            : AccessInfo.fromJson(json['accessInfo'] as Map<String, dynamic>),
    searchInfo:
        json['searchInfo'] == null
            ? null
            : SearchInfo.fromJson(json['searchInfo'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toJson() => {
    'kind': kind,
    'id': id,
    'etag': etag,
    'selfLink': selfLink,
    'volumeInfo': volumeInfo?.toJson(),
    'saleInfo': saleInfo?.toJson(),
    'accessInfo': accessInfo?.toJson(),
    'searchInfo': searchInfo?.toJson(),
  };
}
