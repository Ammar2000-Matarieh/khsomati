class StoreState {}

class Default extends StoreState{}

class Loading extends StoreState {}

class StoreCreated extends StoreState {}

class Erorr extends StoreState {
  final String message;
  Erorr({required this.message});
}
