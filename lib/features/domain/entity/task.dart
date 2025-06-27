class Task {
  final String id;
  final String title;
  final String description;
  final int price;
  final String location;
  final String createdBy;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    required this.createdBy,
  });

  // fromJson
  factory Task.fromJson(String id, Map<String, dynamic> json) {
    return Task(
      id: id,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      location: json['location'] ?? '',
      createdBy: json['created_by'] ?? '',
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'location': location,
      'created_by': createdBy,
    };
  }
}
