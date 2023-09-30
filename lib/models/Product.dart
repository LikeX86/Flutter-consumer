class Product {
  final String id;
  final String name;
  final int price; // Mantenha como int para corresponder ao tipo de dado da API

  Product({required this.id, required this.name, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'], // Mantenha como int
    );
  }
}
