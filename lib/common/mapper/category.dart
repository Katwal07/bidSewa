import 'package:nepa_bid/data/bidder/model/category.dart';
import 'package:nepa_bid/domain/bidder/entity/category.dart';

class CategoryMapper {

  static CategoryElementEntity toCategoryItemEntity(
      CategoryElementModel categoryElementModel) {
    return CategoryElementEntity(
      id: categoryElementModel.id,
      name: categoryElementModel.name,
      description: categoryElementModel.description,
      createdAt: categoryElementModel.createdAt,
      v: categoryElementModel.v,
      image: toImageEntity(categoryElementModel.image!),
    );
  }

  static ImageElementEntity toImageEntity(ImageElementModel imageModel) {
    return ImageElementEntity(
      publicId: imageModel.publicId,
      url: imageModel.url,
    );
  }
}
