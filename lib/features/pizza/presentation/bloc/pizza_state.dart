part of 'pizza_bloc.dart';

abstract class PizzaState extends Equatable {
  const PizzaState();

  @override
  List<Object> get props => [];
}

class PizzaInitial extends PizzaState {}

class PizzaLoaded extends PizzaState {
  final List<PizzaModel> pizzas;
  final List<SizeModel> sizes;
  final List<ToppingModel> toppings;
  final String selectedPizza;
  final String selectedSize;
  final Map<ToppingModel, bool> selectedToppings;

  PizzaLoaded({
    required this.pizzas,
    required this.sizes,
    required this.toppings,
    required this.selectedPizza,
    this.selectedSize = 'Medium',
    required this.selectedToppings,
  });

  @override
  List<Object> get props =>
      [pizzas, sizes, toppings, selectedPizza, selectedSize, selectedToppings];
}
