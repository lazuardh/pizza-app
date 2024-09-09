import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/pizza_model.dart';
import '../../data/models/size.dart';
import '../../data/models/topping_model.dart';

part 'pizza_event.dart';
part 'pizza_state.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  PizzaBloc() : super(PizzaInitial()) {
    on<LoadPizzaData>((event, emit) {
      emit(PizzaLoaded(
        pizzas: PizzaModel.listPizza,
        sizes: SizeModel.selectedSizeList,
        toppings: ToppingModel.toppingList,
        selectedPizza: PizzaModel.listPizza.first.name,
        selectedSize: 'Medium',
        selectedToppings: {
          for (var topping in ToppingModel.toppingList) topping: false,
        },
      ));
    });
    on<UpdateSelectedPizza>((event, emit) {
      final currentState = state;

      if (currentState is PizzaLoaded) {
        final updatedToppings = currentState.toppings.map((topping) {
          final updatedTopping = ToppingModel(
            name: topping.name,
            price: topping.price,
            applicablePizzas: topping.applicablePizzas,
            isEnabled: topping.applicablePizzas.contains(event.selectedPizza),
          );
          return updatedTopping;
        }).toList();

        emit(PizzaLoaded(
          pizzas: currentState.pizzas,
          sizes: currentState.sizes,
          toppings: updatedToppings,
          selectedPizza: event.selectedPizza,
          selectedSize: currentState.selectedSize,
          selectedToppings: currentState.selectedToppings,
        ));
      }
    });

    on<UpdateSelectedSize>((event, emit) {
      final currentState = state;
      if (currentState is PizzaLoaded) {
        emit(PizzaLoaded(
          pizzas: currentState.pizzas,
          sizes: currentState.sizes,
          toppings: currentState.toppings,
          selectedPizza: currentState.selectedPizza,
          selectedSize: event.selectedSize,
          selectedToppings: currentState.selectedToppings,
        ));
      }
    });
    on<UpdateSelectedTopping>((event, emit) {
      final currentState = state;
      if (currentState is PizzaLoaded) {
        final updatedToppings =
            Map<ToppingModel, bool>.from(currentState.selectedToppings)
              ..[event.topping] = event.isSelected;

        emit(PizzaLoaded(
          pizzas: currentState.pizzas,
          sizes: currentState.sizes,
          toppings: currentState.toppings,
          selectedPizza: currentState.selectedPizza,
          selectedSize: currentState.selectedSize,
          selectedToppings: updatedToppings,
        ));
      }
    });
  }
}
