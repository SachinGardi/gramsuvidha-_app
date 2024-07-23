class DropdownCategoryModal {
  int? id;
  String? category;

  DropdownCategoryModal({this.id, this.category});

  ///convert from json to object
  factory DropdownCategoryModal.fromJson(Map<String, dynamic> json) =>
      DropdownCategoryModal(
        id: json["id"],
        category: json["category"],
      );

  /// convert object to json
  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
      };
}
