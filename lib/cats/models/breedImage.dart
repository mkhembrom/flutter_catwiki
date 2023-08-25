class CatTopImage {
  final String? image;
  final String? id;

  CatTopImage({
    this.id,
    this.image,
  });

  factory CatTopImage.fromJson(Map<String, dynamic> map) {
    return CatTopImage(
      id: map['id'],
      image: map['url'],
    );
  }
}
