part of minerva_cache;

class CacheAgentData extends AgentData {
  CacheAgentData({String name = 'cache', super.data})
      : super(name, CacheAgent());
}
