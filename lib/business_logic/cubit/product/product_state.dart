class ProductState {}

class Default extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {}

class ProductAdded extends ProductState {}

class Erorr extends ProductState {
  final String message;

  Erorr({required this.message});

}
