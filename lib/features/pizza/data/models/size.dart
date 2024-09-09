class SizeModel {
  final String size;
  final int price;

  SizeModel(this.size, this.price);

  static List<SizeModel> selectedSizeList = [
    SizeModel('Small', -1),
    SizeModel('Medium', 0),
    SizeModel('Large', 2),
  ];
}
