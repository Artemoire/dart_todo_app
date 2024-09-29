import 'package:rawdog/src/rawdog_models.dart';

abstract class Database {

  Future<void> execSql(String sql); // TODO: ResultSet
  Future<void> rawExec(RawExecute raw);
  Future<R> rawStmt<R>(RawStatement<R> raw);

}
