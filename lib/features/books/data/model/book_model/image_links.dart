class ImageLinks {
  final String? smallThumbnail;
  final String? thumbnail;
  final String? mediumQuality;
  final String? highQuality;

  ImageLinks({
    this.smallThumbnail,
    this.thumbnail,
    this.mediumQuality,
    this.highQuality,
  });

  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    final rawThumbnail = json['thumbnail'] as String?;
    final rawSmallThumbnail = json['smallThumbnail'] as String?;

    return ImageLinks(
      smallThumbnail: rawSmallThumbnail,

      thumbnail: rawThumbnail,
      mediumQuality: rawThumbnail,
      highQuality: rawThumbnail,
    );
  }

  Map<String, dynamic> toJson() => {
    'smallThumbnail': smallThumbnail,
    'thumbnail': thumbnail,
    'mediumQuality': mediumQuality,
    'highQuality': highQuality,
  };
}
