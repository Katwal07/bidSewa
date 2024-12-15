class UserResponseModel {
    UserResponseModel({
        required this.success,
        required this.message,
        required this.user,
        required this.token,
    });

    final bool? success;
    final String? message;
    final UserModel? user;
    final String? token;

    factory UserResponseModel.fromJson(Map<String, dynamic> json){ 
        return UserResponseModel(
            success: json["success"],
            message: json["message"],
            user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
            token: json["token"],
        );
    }

}

class UserModel {
    UserModel({
        required this.profileImage,
        required this.paymentMethods,
        required this.id,
        required this.username,
        required this.password,
        required this.email,
        required this.address,
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
    final PaymentMethodsModel? paymentMethods;
    final String? id;
    final String? username;
    final String? password;
    final String? email;
    final String? address;
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
            paymentMethods: json["paymentMethods"] == null ? null : PaymentMethodsModel.fromJson(json["paymentMethods"]),
            id: json["_id"],
            username: json["username"],
            password: json["password"],
            email: json["email"],
            address: json["address"],
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

class PaymentMethodsModel {
    PaymentMethodsModel({
        required this.bankTransfer,
        required this.esewa,
        required this.khalti,
        required this.imepay,
        required this.paypal,
    });

    final BankTransferModel? bankTransfer;
    final EsewaModel? esewa;
    final KhaltiModel? khalti;
    final ImepayModel? imepay;
    final PaypalModel? paypal;

    factory PaymentMethodsModel.fromJson(Map<String, dynamic> json){ 
        return PaymentMethodsModel(
            bankTransfer: json["bankTransfer"] == null ? null : BankTransferModel.fromJson(json["bankTransfer"]),
            esewa: json["esewa"] == null ? null : EsewaModel.fromJson(json["esewa"]),
            khalti: json["khalti"] == null ? null : KhaltiModel.fromJson(json["khalti"]),
            imepay: json["imepay"] == null ? null : ImepayModel.fromJson(json["imepay"]),
            paypal: json["paypal"] == null ? null : PaypalModel.fromJson(json["paypal"]),
        );
    }

}

class BankTransferModel {
    BankTransferModel({
        required this.bankAccountName,
        required this.bankAccountNumber,
        required this.bankName,
        required this.swiftCode,
    });

    final String? bankAccountName;
    final String? bankAccountNumber;
    final String? bankName;
    final String? swiftCode;

    factory BankTransferModel.fromJson(Map<String, dynamic> json){ 
        return BankTransferModel(
            bankAccountName: json["bankAccountName"],
            bankAccountNumber: json["bankAccountNumber"],
            bankName: json["bankName"],
            swiftCode: json["swiftCode"],
        );
    }

}

class EsewaModel {
    EsewaModel({
        required this.esewaNumber,
    });

    final String? esewaNumber;

    factory EsewaModel.fromJson(Map<String, dynamic> json){ 
        return EsewaModel(
            esewaNumber: json["esewaNumber"],
        );
    }

}

class ImepayModel {
    ImepayModel({
        required this.imepayNumber,
    });

    final String? imepayNumber;

    factory ImepayModel.fromJson(Map<String, dynamic> json){ 
        return ImepayModel(
            imepayNumber: json["imepayNumber"],
        );
    }

}

class KhaltiModel {
    KhaltiModel({
        required this.khaltiNumber,
    });

    final String? khaltiNumber;

    factory KhaltiModel.fromJson(Map<String, dynamic> json){ 
        return KhaltiModel(
            khaltiNumber: json["khaltiNumber"],
        );
    }

}

class PaypalModel {
    PaypalModel({
        required this.paypalEmail,
    });

    final String? paypalEmail;

    factory PaypalModel.fromJson(Map<String, dynamic> json){ 
        return PaypalModel(
            paypalEmail: json["paypalEmail"],
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
