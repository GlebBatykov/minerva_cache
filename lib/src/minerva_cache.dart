part of minerva_cache;

///
class MinervaCache {
  final AgentConnector _connector;

  MinervaCache(AgentConnector connector) : _connector = connector;

  ///
  static MinervaCache of(ServerContext context, {String agentName = 'cache'}) {
    var connector = context.connectors.get(agentName);

    if (connector != null) {
      return MinervaCache(connector);
    } else {
      throw MinervaCacheException(
          'Connector with name: $agentName, not found.');
    }
  }

  ///
  void set(String key, dynamic value, {Duration? expiration}) {
    _connector.cast('set',
        data: {'key': key, 'value': value, 'expiration': expiration});
  }

  ///
  void delete(String key) {
    _connector.cast('delete', data: {'key': key});
  }

  ///
  void changeExpiration(String key, Duration expiration) {
    _connector.cast('change_expiration',
        data: {'key': key, 'expiration': expiration});
  }

  ///
  bool has(String key) {
    return _connector.call('has', data: {'key': key}) as bool;
  }

  ///
  void clear() {
    _connector.cast('clear');
  }

  ///
  void update(String key, dynamic value) {
    _connector.cast('update', data: {'key': key, 'value': value});
  }

  ///
  Future<dynamic> get(String key) async {
    return await _connector.call('get', data: {'key': key});
  }
}
