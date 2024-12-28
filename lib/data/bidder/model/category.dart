
class CategoryElementModel {
    CategoryElementModel({
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
    final ImageElementModel? image;

    factory CategoryElementModel.fromJson(Map<String, dynamic> json){ 
        return CategoryElementModel(
            id: json["_id"],
            name: json["name"],
            description: json["description"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            v: json["__v"],
            image: json["image"] == null ? null : ImageElementModel.fromJson(json["image"]),
        );
    }

}

class ImageElementModel {
    ImageElementModel({
        required this.publicId,
        required this.url,
    });

    final String? publicId;
    final String? url;

    factory ImageElementModel.fromJson(Map<String, dynamic> json){ 
        return ImageElementModel(
            publicId: json["public_id"],
            url: json["url"] ,
        );
    }

}
