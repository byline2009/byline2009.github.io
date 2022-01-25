class Category {
  String? id;
  String? createdAt;
  String? name;

  Category({this.id, this.name, this.createdAt});

  // receiving data from server
  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        createdAt = json['createdAt'];

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt,
    };
  }
}
