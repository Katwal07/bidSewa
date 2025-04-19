import 'package:nepa_bid/core/usecase/usecase.dart';

abstract class PaginationNewsInEvent {}

class PaginatedNewsInEvent extends PaginationNewsInEvent{
  final UseCase useCase;

  PaginatedNewsInEvent({required this.useCase});
}