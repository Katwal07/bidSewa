import 'package:nepa_bid/core/usecase/usecase.dart';

abstract class PaginationEventForAuctioneer {}

class PaginatedEventForAuctioneer extends PaginationEventForAuctioneer{
  final UseCase usecase;

  PaginatedEventForAuctioneer({required this.usecase});
}