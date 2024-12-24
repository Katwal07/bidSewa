class ItemEntity {
  final String? itemId;
  final String? endTime;

  ItemEntity({required this.itemId, required this.endTime});

  @override
  String toString(){
    return '$itemId';
  }
}