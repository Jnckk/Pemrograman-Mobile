class Coffemenu {
  String title;
  String description;
  List<String> ingredients;
  String image;
  int id;

  Coffemenu({
    required this.title,
    required this.description,
    required this.ingredients,
    required this.image,
    required this.id,
  });

  factory Coffemenu.fromJson(Map<String, dynamic> json) {
    return Coffemenu(
      title: json["title"],
      description: json["description"],
      ingredients: List<String>.from(json["ingredients"].map((x) => x)),
      image: json["image"],
      id: json["id"],
    );
  }
}
