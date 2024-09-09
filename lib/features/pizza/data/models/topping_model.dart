class ToppingModel {
  final String name;
  final double price;
  final List<String> applicablePizzas;
  bool isEnabled;

  ToppingModel({
    required this.name,
    required this.price,
    required this.applicablePizzas,
    this.isEnabled = true,
  });

  void updateIsEnabled(String selectedPizza) {
    isEnabled = applicablePizzas.contains(selectedPizza);
  }

  static List<ToppingModel> toppingList = [
    ToppingModel(name: 'Avocado', price: 1.0, applicablePizzas: ['Pizza1']),
    ToppingModel(
        name: 'Broccoli',
        price: 1.0,
        applicablePizzas: ['Pizza1', 'Pizza2', 'Pizza3']),
    ToppingModel(
        name: 'Onions',
        price: 1.0,
        applicablePizzas: ['Pizza1', 'Pizza2', 'Pizza3']),
    ToppingModel(
        name: 'Zucchini',
        price: 1.0,
        applicablePizzas: ['Pizza1', 'Pizza2', 'Pizza3']),
    ToppingModel(name: 'Lobster', price: 2.0, applicablePizzas: ['Pizza2']),
    ToppingModel(name: 'Oyster', price: 2.0, applicablePizzas: ['Pizza2']),
    ToppingModel(name: 'Salmon', price: 2.0, applicablePizzas: ['Pizza3']),
    ToppingModel(
        name: 'Tuna', price: 2.0, applicablePizzas: ['Pizza1', 'Pizza3']),
    ToppingModel(
        name: 'Bacon', price: 3.0, applicablePizzas: ['Pizza2', 'Pizza3']),
    ToppingModel(name: 'Duck', price: 3.0, applicablePizzas: ['Pizza3']),
    ToppingModel(
        name: 'Ham',
        price: 3.0,
        applicablePizzas: ['Pizza1', 'Pizza2', 'Pizza3']),
    ToppingModel(name: 'Sausage', price: 3.0, applicablePizzas: ['Pizza3']),
  ];
}
