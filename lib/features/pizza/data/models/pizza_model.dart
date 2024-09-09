class PizzaModel {
  final String name;
  final int price;

  PizzaModel(this.name, this.price);

  static List<PizzaModel> listPizza = [
    PizzaModel('Pizza1', 8),
    PizzaModel('Pizza2', 10),
    PizzaModel('Pizza3', 12),
  ];
}
