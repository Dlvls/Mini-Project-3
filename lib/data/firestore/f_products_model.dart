class FirestoreProductModel {
  final String documentId;
  final String id;
  final String title;
  final String image;
  final String description;
  final double price;
  final Rating rating;
  final String category;

  FirestoreProductModel({
    required this.documentId,
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
  });

  factory FirestoreProductModel.fromMap(
      Map<String, dynamic> map, String documentId) {
    // Log the document ID and all relevant fields
    print('FirestoreProductModel documentId: $documentId');
    print(
        'Category field from Firestore: ${map['category']} (type: ${map['category']?.runtimeType})');

    return FirestoreProductModel(
      documentId: documentId,
      id: map['id']?.toString() ?? '', // Ensure ID is a String
      title: map['title']?.toString() ?? '',
      image: map['image']?.toString() ?? '',
      description: map['description']?.toString() ?? '',
      price: (map['price'] is double
              ? map['price']
              : (map['price'] as num?)?.toDouble()) ??
          0.0,
      rating: Rating.fromMap(map['rating'] ?? {}),
      category:
          map['category']?.toString() ?? '', // Ensure category is a String
    );
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      rate: (map['rate'] is double
              ? map['rate']
              : (map['rate'] as num?)?.toDouble()) ??
          0.0,
      count: (map['count'] as int?) ?? 0,
    );
  }
}
