part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadProductsEvent extends ProductEvent {
  final int page;
  final int limit;

  LoadProductsEvent({required this.page, this.limit = 10});

  @override
  List<Object> get props => [page, limit];
}

class EditProductEvent extends ProductEvent {
  final int productId;
  final Map<String, dynamic> updatedData;

  EditProductEvent({required this.productId, required this.updatedData});

  @override
  List<Object> get props => [productId, updatedData];
}
