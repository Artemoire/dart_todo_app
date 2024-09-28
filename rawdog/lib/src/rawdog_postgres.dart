import 'package:rawdog/src/rawdog_base.dart';
import 'package:postgres/postgres.dart';

// TODO: Not a driver
class PostgresDbDriver implements DbDriver {
  late final Connection _conn;

  PostgresDbDriver();

  open(
    Endpoint endpoint, {
    ConnectionSettings? settings,
  }) async {
    _conn = await Connection.open(endpoint, settings: settings);
  }

  @override
  Future<List<List<Object?>>> execute(String sql) {
    return _conn.execute(sql);
  }
}
