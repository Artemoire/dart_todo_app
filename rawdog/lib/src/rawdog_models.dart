abstract class RawExecute {
  String toSQL();
}

abstract class RawStatement<T> extends RawExecute {
  T marshal(List<List<Object?>> rows);
}
