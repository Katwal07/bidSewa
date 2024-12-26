import 'package:nepa_bid/data/auth/model/bidder_user.dart';

import '../../domain/auth/entity/bidder_user.dart';

class BidderUserMapper {
  static BidderUserEntity toBidderUserEntity(BidderUserModel bidderUsermodel) {
    return BidderUserEntity(
      success: bidderUsermodel.success,
      user: toUserEntity(bidderUsermodel.user!),
    );
  }

  static UserEntity toUserEntity(UserModel userModel) {
    return UserEntity(
      profileImage: toProfileImageEntity(userModel.profileImage!),
      id: userModel.id,
      username: userModel.username,
      password: userModel.password,
      email: userModel.email,
      phone: userModel.phone,
      role: userModel.role,
      unpaidCommission: userModel.unpaidCommission,
      auctionWon: userModel.auctionWon,
      trial: userModel.trial,
      sellCount: userModel.sellCount,
      moneySpent: userModel.moneySpent,
      createdAt: userModel.createdAt,
      v: userModel.v,
    );
  }

  static ProfileImageEntity toProfileImageEntity(
      ProfileImageModel profileImageModel) {
    return ProfileImageEntity(
      publicId: profileImageModel.publicId,
      url: profileImageModel.url,
    );
  }
}
