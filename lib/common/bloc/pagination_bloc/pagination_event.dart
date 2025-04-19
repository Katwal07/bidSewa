import 'package:nepa_bid/core/usecase/usecase.dart';

abstract class PaginationEvent {}

class PaginatedEvent extends PaginationEvent{
  final UseCase useCase;

  PaginatedEvent({required this.useCase});
}