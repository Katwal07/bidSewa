
class PlaceBidModel {
  final int? amount;

  PlaceBidModel({required this.amount});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
    };
  }
}
