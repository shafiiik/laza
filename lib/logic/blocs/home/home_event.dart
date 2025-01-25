part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadHomeEvent extends HomeEvent {
  final int page;
  final int limit;

  LoadHomeEvent({required this.page, this.limit = 10});
  @override
  List<Object> get props => [page, limit];
}

class EditProductEvent extends HomeEvent {
  final int productId;
  final Map<String, dynamic> updatedData;

  EditProductEvent({required this.productId, required this.updatedData});

  @override
  List<Object> get props => [productId, updatedData];
}
