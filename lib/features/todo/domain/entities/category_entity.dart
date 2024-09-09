class CategoryEntity {
  final String category;

  CategoryEntity(this.category);

  static List<CategoryEntity> listCategory = [
    CategoryEntity('Notes'),
    CategoryEntity('Highlights'),
    CategoryEntity('Favorite Notes'),
  ];
}
