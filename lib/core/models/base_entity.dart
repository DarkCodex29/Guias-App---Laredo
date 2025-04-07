abstract class BaseEntity {
  String get id;

  @override
  bool operator ==(Object other);

  @override
  int get hashCode;
}
