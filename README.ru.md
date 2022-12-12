<div align="center">

[![pub package](https://img.shields.io/pub/v/minerva_mcache.svg?label=minerva_mcache&color=blue)](https://pub.dev/packages/minerva_mcache)

**Языки:**

[![English](https://img.shields.io/badge/Language-English-blue?style=?style=flat-square)](README.md)
[![Russian](https://img.shields.io/badge/Language-Russian-blue?style=?style=flat-square)](README.ru.md)

</div>

- [О пакете](#о-пакете)
- [Как использовать](#как-использовать)

# О пакете

Этот пакет является дополнительным пакетом для [Minerva](https://github.com/GlebBatykov/minerva) фреймворка, для использования [mcache](https://github.com/GlebBatykov/mcache) пакета в многоизолятной обработки запросов.

Данный пакет предоставляет готовый [agent](https://github.com/GlebBatykov/minerva#agents) для Minerva фреймворка, который предоставляет доступ к кэшу из разных экземпляров сервера.

# Как использовать

Вы можете добавить агента при помощи класса `CacheAgentData`, в таком случае стандартным именем агента будет `cache`, вы можете задать дополнительные настройки для работы кэша. Либо вы можете самостоятельно указать данные для агента, при помощи класса `AgentData`.

Пример добавления агента в классе `MinervaAgentsBuilder` при помощи `CacheAgentData`:

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

Пример добавления агента в классе `MinervaAgentsBuilder` при помощи `AgentData`:

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

Получить коннектор для этого агента вы можете по его имени.

Пример получение коннектора для агента по его имени:

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

Для большего удобства взаимодействия с агентом существует класс `MinervaCache`. Вы можете использовать данный интерфейс взаимодействия создав экземпляр класса `MinervaCache`. Создать экземпляр класса `MinervaCache` вы можете передав в его конструктор коннектор для агента кэширования, либо использовать его метод `of`, передав в него наш `ServerContext`.

Класс `MinervaCache` содержит методы для всех основных операций пакета `mcache`, таких как:

- set;
- get;
- update;
- delete;
- has;
- clear.

Пример создания экземпляра класса `MinervaCache` при помощи метода `of`:

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

Пример создания экземпляра класса `MinervaCache` при помощи передачи в него коннектора:

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
