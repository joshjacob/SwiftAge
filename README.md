# SwiftAge

SwiftAge is an extension to [PostgresNIO](https://github.com/vapor/postgres-nio) that enables quering and response parsing of graph databases with the [Apache AGE](https://github.com/apache/age/) extension to PostgreSQL.

## Getting started

#### Adding the dependency

For Vapor of other projects using a `Package.swift` file, SwiftAge can be added as a dependency:

```swift
  dependencies: [
    .package(url: "https://github.com/joshjacob/SwiftAge"),
    ...
  ]
  ...
  targets: [
    .target(name: "MyTarget", dependencies: [
      .product(name: "SwiftAge", package: "SwiftAge"),
    ])
  ]
```

For those developing in Xcode, the dependency can be added in the "Frameworks and Libraries" section of the "General" tab for your target.

#### Connection and Querying

SwiftAge adds querying extensions on top of the PostgresNIO `PostgresConnection` so creation of that connection happens according to PostgresNIO documentation:

```swift
   let connection = try await PostgresConnection.connect(
     on: eventLoopGroup.next(),
     configuration: config,
     id: 1,
     logger: logger
   ).get()
````

A convenience method is provided to set up ApacheAGE:

```swift
   try await connection.setUpAge(logger: logger)
   // runs:
   //    LOAD 'age';
   //    SET search_path = ag_catalog, "$user", public;
```

After that, graph querying can happen:

```swift
   let agRows = try connection.execCypher(
      "SELECT * FROM cypher('test_graph_1', $$ MATCH (v:Person) RETURN v $$) as (v agtype);", 
      logger: logger).wait()
```

The returned `CypherQueryResult` struct contains the `PostgresQueryMetadata` data similar to `PostgresQueryResult` but the `rows` field is an array `AGValue`. The `AGValue` type can be one of the scalar types defined by [Apache AGE](https://age.apache.org/age-manual/master/intro/types.html) as well as a struct to represent a Vertex or an Edge.

## Getting started

See [SwiftAgeExamples](https://github.com/joshjacob/SwiftAgeExamples) for additional examples.
