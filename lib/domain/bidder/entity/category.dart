

class CategoryElementEntity {
    CategoryElementEntity({
        required this.id,
        required this.name,
        required this.description,
        required this.createdAt,
        required this.v,
        required this.image,
    });

    final String? id;
    final String? name;
    final String? description;
    final DateTime? createdAt;
    final int? v;
    final ImageElementEntity? image;
}

class ImageElementEntity {
    ImageElementEntity({
        required this.publicId,
        required this.url,
    });

    final String? publicId;
    final String? url;
}
