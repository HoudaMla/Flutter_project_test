class Product {
  final String name;
  final String image;
  final double price;
  final String details;
  final int quantity;

  const Product({
    required this.name,
    required this.image,
    required this.price,
    required this.details,
    this.quantity = 1,
  });
}