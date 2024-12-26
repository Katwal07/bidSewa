class BidderUserEntity {
    BidderUserEntity({
        required this.success,
        required this.user,
    });

    final bool? success;
    final UserEntity? user;
}

class UserEntity {
    UserEntity({
        required this.profileImage,
        required this.id,
        required this.username,
        required this.password,
        required this.email,
        required this.phone,
        required this.role,
        required this.unpaidCommission,
        required this.auctionWon,
        required this.trial,
        required this.sellCount,
        required this.moneySpent,
        required this.createdAt,
        required this.v,
    });

    final ProfileImageEntity? profileImage;
    final String? id;
    final String? username;
    final String? password;
    final String? email;
    final String? phone;
    final String? role;
    final int? unpaidCommission;
    final int? auctionWon;
    final bool? trial;
    final int? sellCount;
    final int? moneySpent;
    final DateTime? createdAt;
    final int? v;
}

class ProfileImageEntity {
    ProfileImageEntity({
        required this.publicId,
        required this.url,
    });

    final String? publicId;
    final String? url;

}
