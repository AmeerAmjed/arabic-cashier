abstract class BaseModel {
  final int? id;

  BaseModel(this.id);

  Map<String, dynamic> toMap();
}
