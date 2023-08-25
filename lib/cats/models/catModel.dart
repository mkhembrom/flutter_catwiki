class CatModel {
  final String? image;
  final String? id;

  CatModel({
    this.id,
    this.image,
  });

  factory CatModel.fromJson(Map<String, dynamic> map) {
    return CatModel(
      id: map['id'],
      image: map['url'],
    );
  }
}
