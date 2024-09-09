part of 'pizza_bloc.dart';

abstract class PizzaEvent extends Equatable {
  const PizzaEvent();

  @override
  List<Object> get props => [];
}

class LoadPizzaData extends PizzaEvent {}

class UpdateSelectedPizza extends PizzaEvent {
  final String selectedPizza;

  UpdateSelectedPizza(this.selectedPizza);

  @override
  List<Object> get props => [selectedPizza];
}

class UpdateSelectedSize extends PizzaEvent {
  final String selectedSize;

  UpdateSelectedSize(this.selectedSize);

  @override
  List<Object> get props => [selectedSize];
}

class UpdateSelectedTopping extends PizzaEvent {
  final ToppingModel topping;
  final bool isSelected;

  UpdateSelectedTopping(this.topping, this.isSelected);

  @override
  List<Object> get props => [topping, isSelected];
}
