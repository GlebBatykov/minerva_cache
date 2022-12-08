part of minerva_cache;

/// Implements an agent for storing the cache.
class CacheAgent extends Agent {
  final bool _deleteOnExpire;

  final Duration _checkPeriod;

  late final Cache _cache;

  CacheAgent(
      {bool deleteOnExpire = true,
      Duration checkPeriod = const Duration(seconds: 600)})
      : _deleteOnExpire = deleteOnExpire,
        _checkPeriod = checkPeriod;

  @override
  void initialize(Map<String, dynamic> data) {
    _cache = Cache(deleteOnExpire: _deleteOnExpire, checkPeriod: _checkPeriod);
  }

  @override
  dynamic call(String action, Map<String, dynamic> data) {
    switch (action) {
      case ('get'):
        var key = data['key'] as String?;

        if (key != null) {
          return _cache[key];
        } else {
          break;
        }
      case ('delete'):
        var key = data['key'] as String?;

        if (key != null) {
          return _cache.delete(key);
        } else {
          break;
        }
      case ('has'):
        var key = data['key'] as String?;

        if (key != null) {
          return _cache.has(key);
        } else {
          break;
        }
    }
  }

  @override
  void cast(String action, Map<String, dynamic> data) {
    switch (action) {
      case ('set'):
        var key = data['key'] as String?;

        var value = data['value'];

        var expiration = data['expiration'] as Duration?;

        if (key != null) {
          _cache.set(key, value,
              expirationSetting: ExpirationSetting(expiration: expiration));
        }

        break;
      case ('delete'):
        var key = data['key'] as String?;

        if (key != null) {
          _cache.delete(key);
        }

        break;
      case ('clear'):
        _cache.clear();

        break;
      case ('change_expiration'):
        var key = data['key'] as String?;

        var expiration = data['expiration_setting'] as ExpirationSetting?;

        if (key != null && expiration != null) {
          _cache.changeExpiration(key, expiration);
        }

        break;
      case ('update'):
        var key = data['key'] as String?;

        var value = data['value'];

        if (key != null) {
          _cache.update(key, value);
        }

        break;
    }
  }

  @override
  Future<void> dispose() async {
    return _cache.dispose();
  }
}
