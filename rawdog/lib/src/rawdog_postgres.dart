import 'package:rawdog/src/rawdog_base.dart';
import 'package:postgres/postgres.dart';
import 'package:rawdog/src/rawdog_models.dart';

class PostgresDatabase extends Database {
  late final Connection _conn;

  PostgresDatabase();

  open(
    Endpoint endpoint, {
    ConnectionSettings? settings,
  }) async {
    _conn = await Connection.open(endpoint, settings: settings);
  }

  @override
  Future<void> execSql(String sql) => _conn.execute(sql);

  @override
  Future<void> rawExec(RawExecute raw) => _conn.execute(raw.toSQL());

  @override
  Future<R> rawStmt<R>(RawStatement<R> raw) async {
    var res = await _conn.execute(raw.toSQL());
    return raw.marshal(res);
  }
}
