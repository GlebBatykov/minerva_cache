<div align="center">

[![pub package](https://img.shields.io/pub/v/minerva_mcache.svg?label=minerva_mcache&color=blue)](https://pub.dev/packages/minerva_mcache)

**Languages:**

[![English](https://img.shields.io/badge/Language-English-blue?style=?style=flat-square)](README.md)
[![Russian](https://img.shields.io/badge/Language-Russian-blue?style=?style=flat-square)](README.ru.md)

</div>

# About package

This package is an additional package for [Minerva](https://github.com/GlebBatykov/minerva) framework, to use [mcache](https://github.com/GlebBatykov/mcache) of the package in multi-way request processing.

This package provides a ready-made [agent](https://github.com/GlebBatykov/minerva#agents) for the Minerva framework, which provides access to the cache from different server instances.

# How to use

You can add an agent using the `CacheAgentData` class, in this case the standard name of the agent will be `cache`, you can set additional settings for cache operation. Or you can specify the data for the agent yourself, using the `AgentData` class.

Example of adding an agent in the `MinervaAgentsBuilder` class using `CacheAgentData`:

```dart
class AgentsBuilder extends MinervaAgentsBuilder {
  @override
  List<AgentData> build() {
    final agents = <AgentData>[];

    agents.add(CacheAgentData());

    return agents;
  }
}
```

Example of adding an agent in the `MinervaAgentsBuilder` class using `AgentData`:

```dart
class AgentsBuilder extends MinervaAgentsBuilder {
  @override
  List<AgentData> build() {
    final agents = <AgentData>[];

    agents.add(AgentData('cache', CacheAgent()));

    return agents;
  }
}
```

You can get a connector for this agent by its name.

Example getting a connector for an agent by its name:

```dart
class CounterApi extends Api {
  late final AgentConnector _connector;

  @override
  void initialize(ServerContext context) {
    _connector = context.connectors['cache']!;
  }

  @override
  void build(Endpoints endpoints) {}
}
```

For more convenience of interaction with the agent, there is a class `MinervaCache`. You can use this interaction interface by creating an instance of the `MinervaCache` class. You can create an instance of the `MinervaCache` class by passing a connector for the caching agent to its constructor, or use its `of` method by passing our `ServerContext` to it.

The `MinervaCache` class contains methods for all the basic operations of the `mcache` package, such as:

- set;
- get;
- update;
- delete;
- has;
- clear.

Example of creating an instance of the `MinervaCache` class using the `of` method:

```dart
class CounterApi extends Api {
  late final MinervaCache _cache;

  @override
  void initialize(ServerContext context) {
    _cache = MinervaCache.of(context);
  }

  @override
  void build(Endpoints endpoints) {}
}
```

Example of creating an instance of the `MinervaCache` class by passing a connector to it:

```dart
class CounterApi extends Api {
  late final MinervaCache _cache;

  @override
  void initialize(ServerContext context) {
    final connector = context.connectors['cache']!;

    _cache = MinervaCache(connector);
  }

  @override
  void build(Endpoints endpoints) {}
}
```
