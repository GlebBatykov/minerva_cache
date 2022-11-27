part of minerva_cache;

class CacheAgentData extends AgentData {
  CacheAgentData(
      {String name = 'cache',
      bool deleteOnExpire = true,
      Duration checkPeriod = const Duration(seconds: 600)})
      : super(
            name,
            CacheAgent(
                deleteOnExpire: deleteOnExpire, checkPeriod: checkPeriod));
}
