part of minerva_mcache;

/// Used for access to cached values in agent.
class MinervaCache {
  final AgentConnector _connector;

  MinervaCache(AgentConnector connector) : _connector = connector;

  /// Gets connector for agent with [agentName] from [context] and uses it for work.
  static MinervaCache of(ServerContext context, {String agentName = 'cache'}) {
    var connector = context.connectors.get(agentName);

    if (connector != null) {
      return MinervaCache(connector);
    } else {
      throw MinervaCacheException(
          'Connector with name: $agentName, not found.');
    }
  }

  /// Sets [value] by [key].
  void set(String key, dynamic value, {Duration? expiration}) {
    _connector.cast('set',
        data: {'key': key, 'value': value, 'expiration': expiration});
  }

  /// Deletes value by [key].
  void delete(String key) {
    _connector.cast('delete', data: {'key': key});
  }

  /// Changes value expiration by [key].
  void changeExpiration(String key, Duration expiration) {
    _connector.cast('change_expiration',
        data: {'key': key, 'expiration': expiration});
  }

  /// Checks is value by [key] has.
  bool has(String key) {
    return _connector.call('has', data: {'key': key}) as bool;
  }

  /// Clears all values.
  void clear() {
    _connector.cast('clear');
  }

  /// If cache contains value by [key] updates it.
  ///
  /// Updates the lifetime of the value.
  void update(String key, dynamic value) {
    _connector.cast('update', data: {'key': key, 'value': value});
  }

  /// Gets value by [key].
  Future<dynamic> get(String key) async {
    return await _connector.call('get', data: {'key': key});
  }
}
