class BidderUserModel {
    BidderUserModel({
        required this.success,
        required this.user,
    });

    final bool? success;
    final UserModel? user;

    factory BidderUserModel.fromJson(Map<String, dynamic> json){ 
        return BidderUserModel(
            success: json["success"],
            user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        );
    }

}

class UserModel {
    UserModel({
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

    final ProfileImageModel? profileImage;
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

    factory UserModel.fromJson(Map<String, dynamic> json){ 
        return UserModel(
            profileImage: json["profileImage"] == null ? null : ProfileImageModel.fromJson(json["profileImage"]),
            id: json["_id"],
            username: json["username"],
            password: json["password"],
            email: json["email"],
            phone: json["phone"],
            role: json["role"],
            unpaidCommission: json["unpaidCommission"],
            auctionWon: json["auctionWon"],
            trial: json["trial"],
            sellCount: json["sellCount"],
            moneySpent: json["moneySpent"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            v: json["__v"],
        );
    }

}

class ProfileImageModel {
    ProfileImageModel({
        required this.publicId,
        required this.url,
    });

    final String? publicId;
    final String? url;

    factory ProfileImageModel.fromJson(Map<String, dynamic> json){ 
        return ProfileImageModel(
            publicId: json["public_id"],
            url: json["url"],
        );
    }

}
