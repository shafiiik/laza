part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<Category> categories;
  final List<Product> products;
  final bool hasMore;
  final List<Product> allProducts;
  final int currentPage;

  HomeLoadedState({
    required this.categories,
    required this.products,
    required this.hasMore,
    required this.allProducts,
    required this.currentPage,
  });

  @override
  List<Object> get props => [
        categories,
        products,
        hasMore,
        allProducts,
        currentPage,
      ];
}

class HomeErrorState extends HomeState {
  final String error;

  HomeErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
