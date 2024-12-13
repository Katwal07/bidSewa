class AuctioneerUserEntity {
    AuctioneerUserEntity({
        required this.success,
        required this.message,
        required this.user,
        required this.token,
    });

    final bool? success;
    final String? message;
    final AuctioneerUserClassEntity? user;
    final String? token;

}

class AuctioneerUserClassEntity {
    AuctioneerUserClassEntity({
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

    final ProfileImageEntity? profileImage;
    final PaymentMethodsEntity? paymentMethods;
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
}

class PaymentMethodsEntity {
    PaymentMethodsEntity({
        required this.bankTransfer,
        required this.esewa,
        required this.khalti,
        required this.imepay,
        required this.paypal,
    });

    final BankTransferEntity? bankTransfer;
    final EsewaEntity? esewa;
    final KhaltiEntity? khalti;
    final ImepayEntity? imepay;
    final PaypalEntity? paypal;
}

class BankTransferEntity {
    BankTransferEntity({
        required this.bankAccountName,
        required this.bankAccountNumber,
        required this.bankName,
        required this.swiftCode,
    });

    final String? bankAccountName;
    final String? bankAccountNumber;
    final String? bankName;
    final String? swiftCode;

}
class EsewaEntity {
    EsewaEntity({
        required this.esewaNumber,
    });

    final String? esewaNumber;

}

class ImepayEntity {
    ImepayEntity({
        required this.imepayNumber,
    });

    final String? imepayNumber;

}

class KhaltiEntity {
    KhaltiEntity({
        required this.khaltiNumber,
    });

    final String? khaltiNumber;

}

class PaypalEntity {
    PaypalEntity({
        required this.paypalEmail,
    });

    final String? paypalEmail;

}

class ProfileImageEntity {
    ProfileImageEntity({
        required this.publicId,
        required this.url,
    });

    final String? publicId;
    final String? url;

}
