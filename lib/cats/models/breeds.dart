class CatBreed {
  final String id;
  final String name;
  final String description;
  final String origin;
  final String? referenceImageId;

  CatBreed({
    required this.id,
    required this.name,
    required this.description,
    required this.origin,
    this.referenceImageId,
  });

  factory CatBreed.fromJson(Map<String, dynamic> map) {
    return CatBreed(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      origin: map['origin'] as String,
      referenceImageId: map['reference_image_id'],
    );
  }
}
