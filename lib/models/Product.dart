class Product {
  final int id;
  final String name;
  final price;

  Product({required this.id, required this.name, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(id: json['id'], name: json['name'], price: json['price']);
  }
}
