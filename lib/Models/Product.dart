class Product {
  final int id;
  final String barcode;
  final String name;
  final double price;

  Product({this.id, this.barcode, this.name, this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      barcode: json['barcode'],
      name: json['name'],
      price: json['price'].toDouble(),
    );
  }
}
