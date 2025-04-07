abstract class BaseModel {
  Map<String, dynamic> toMap();
  String get id;
}

abstract class BaseEntity {
  String get id;
}

abstract class BaseMapper<T extends BaseModel, E extends BaseEntity> {
  E toEntity(T model);
  T toModel(E entity);
  List<E> toEntityList(List<T> models) =>
      models.map((e) => toEntity(e)).toList();
  List<T> toModelList(List<E> entities) =>
      entities.map((e) => toModel(e)).toList();
}
