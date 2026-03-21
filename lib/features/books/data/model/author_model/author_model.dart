import 'package:bookna_app/features/books/domain/entities/author.dart';

class AuthorModel extends Author {
  // ignore: use_super_parameters
  AuthorModel({
    List<String>? alternateNames,
    String? birthDate,
    String? deathDate,
    String? key,
    String? name,
    List<String>? topSubjects,
    String? topWork,
    String? type,
    int? workCount,
    double? ratingsAverage,
    double? ratingsSortable,
    int? ratingsCount,
    int? ratingsCount1,
    int? ratingsCount2,
    int? ratingsCount3,
    int? ratingsCount4,
    int? ratingsCount5,
    int? wantToReadCount,
    int? alreadyReadCount,
    int? currentlyReadingCount,
    int? readingLogCount,
    String? version,
  }) : super(
         alternateNames: alternateNames,
         birthDate: birthDate,
         deathDate: deathDate,
         key: key,
         name: name,
         topSubjects: topSubjects,
         topWork: topWork,
         type: type,
         workCount: workCount,
         ratingsAverage: ratingsAverage,
         ratingsSortable: ratingsSortable,
         ratingsCount: ratingsCount,
         ratingsCount1: ratingsCount1,
         ratingsCount2: ratingsCount2,
         ratingsCount3: ratingsCount3,
         ratingsCount4: ratingsCount4,
         ratingsCount5: ratingsCount5,
         wantToReadCount: wantToReadCount,
         alreadyReadCount: alreadyReadCount,
         currentlyReadingCount: currentlyReadingCount,
         readingLogCount: readingLogCount,
         version: version,
       );

  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    String? toSafeString(dynamic value) {
      if (value == null) return null;
      return value.toString();
    }

    return AuthorModel(
      alternateNames:
          json['alternate_names'] != null
              ? (json['alternate_names'] as List<dynamic>).cast<String>()
              : null,
      birthDate: toSafeString(json['birth_date']),
      deathDate: toSafeString(json['death_date']),
      key: toSafeString(json['key']),
      name: toSafeString(json['name']),
      topSubjects:
          json['top_subjects'] != null
              ? (json['top_subjects'] as List<dynamic>).cast<String>()
              : null,
      topWork: toSafeString(json['top_work']),
      type: toSafeString(json['type']),
      workCount: json['work_count'] as int?,
      ratingsAverage: (json['ratings_average'] as num?)?.toDouble(),
      ratingsSortable: (json['ratings_sortable'] as num?)?.toDouble(),
      ratingsCount: json['ratings_count'] as int?,
      ratingsCount1: json['ratings_count_1'] as int?,
      ratingsCount2: json['ratings_count_2'] as int?,
      ratingsCount3: json['ratings_count_3'] as int?,
      ratingsCount4: json['ratings_count_4'] as int?,
      ratingsCount5: json['ratings_count_5'] as int?,
      wantToReadCount: json['want_to_read_count'] as int?,
      alreadyReadCount: json['already_read_count'] as int?,
      currentlyReadingCount: json['currently_reading_count'] as int?,
      readingLogCount: json['readinglog_count'] as int?,
      version: toSafeString(json['_version_']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alternate_names': alternateNames,
      'birth_date': birthDate,
      'death_date': deathDate,
      'key': key,
      'name': name,
      'top_subjects': topSubjects,
      'top_work': topWork,
      'type': type,
      'work_count': workCount,
      'ratings_average': ratingsAverage,
      'ratings_sortable': ratingsSortable,
      'ratings_count': ratingsCount,
      'ratings_count_1': ratingsCount1,
      'ratings_count_2': ratingsCount2,
      'ratings_count_3': ratingsCount3,
      'ratings_count_4': ratingsCount4,
      'ratings_count_5': ratingsCount5,
      'want_to_read_count': wantToReadCount,
      'already_read_count': alreadyReadCount,
      'currently_reading_count': currentlyReadingCount,
      'readinglog_count': readingLogCount,
      '_version_': version,
    };
  }
}
