

class Recipe {
  int id;
  String name;
  List<String> ingredients;
  List<String> instructions;
  int prepTimeMinutes;
  int cookTimeMinutes;
  int servings;
  String difficulty;
  String cuisine;
  int caloriesPerServing;
  List<String> tags;
  int userId;
  String image;
  double rating;
  int reviewCount;
  List<String> mealType;

  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.difficulty,
    required this.cuisine,
    required this.caloriesPerServing,
    required this.tags,
    required this.userId,
    required this.image,
    required this.rating,
    required this.reviewCount,
    required this.mealType,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    id: json["id"],
    name: json["name"],
    ingredients: List<String>.from(json["ingredients"].map((x) => x)),
    instructions: List<String>.from(json["instructions"].map((x) => x)),
    prepTimeMinutes: json["prepTimeMinutes"],
    cookTimeMinutes: json["cookTimeMinutes"],
    servings: json["servings"],
    difficulty: json["difficulty"],
    cuisine: json["cuisine"],
    caloriesPerServing: json["caloriesPerServing"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    userId: json["userId"],
    image: json["image"],
    rating: json["rating"]?.toDouble(),
    reviewCount: json["reviewCount"],
    mealType: List<String>.from(json["mealType"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
    "instructions": List<dynamic>.from(instructions.map((x) => x)),
    "prepTimeMinutes": prepTimeMinutes,
    "cookTimeMinutes": cookTimeMinutes,
    "servings": servings,
    "difficulty": difficulty,
    "cuisine": cuisine,
    "caloriesPerServing": caloriesPerServing,
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "userId": userId,
    "image": image,
    "rating": rating,
    "reviewCount": reviewCount,
    "mealType": List<dynamic>.from(mealType.map((x) => x)),
  };
}
