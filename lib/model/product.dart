class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final String image;
  final num price;
  final double rate;

  //Constructeur avec les paramètres nommés "required"
  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.category,
    required this.description,
    required this.rate,
  });
  String getPrice() => "${price.toStringAsFixed(2)}€";

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'category': this.category,
      'image': this.image,
      'price': this.price,
      'rate': this.rate,
    };
  }
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
      other.id == id;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      image: map['image'] as String,
      price: map['price'] as num,
      rate: (map['rating'] != null && map['rating']['rate'] != null)
          ? (map['rating']['rate'] as num).toDouble()
          : 0.0,
    );
  }

}
