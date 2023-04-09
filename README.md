# SwiftAge

SwiftAge is an extension to [PostgresNIO](https://github.com/vapor/postgres-nio) that enables quering and response parsing of graph databases with the [Apache AGE](https://github.com/apache/age/) extension to PostgreSQL.

## Getting started

#### Adding the dependency

For Vapor of other projects using a `Package.swift` file, SwiftAge can be added as a dependency:

```swift
  dependencies: [
    .package(url: "https://github.com/joshjacob/SwiftAge", from: "1.0.0-alpha.1"),
    ...
  ]
  ...
  targets: [
    .target(name: "MyTarget", dependencies: [
      ...
      .product(name: "SwiftAge", package: "SwiftAge"),
    ])
  ]
```

For those developing in Xcode, the dependency can be added in the "Frameworks and Libraries" section of the "General" tab for your target.


#### Connection

SwiftAge adds querying extensions on top of the PostgresNIO `PostgresConnection` so creation of that connection happens according to PostgresNIO documentation:

```swift
   let connection = try await PostgresConnection.connect(
     on: eventLoopGroup.next(),
     configuration: config,
     id: 1,
     logger: logger
   ).get()
````


#### Set up AGE

Each connection needs commands run to set up AGE. A convenience method is provided for this:

```swift
try await connection.setUpAge(logger: logger)
// will run:
//	LOAD 'age';
//	SET search_path = ag_catalog, "$user", public;
//	"SELECT cast(typelem as INTEGER) FROM pg_type WHERE typname='_agtype'"
```

The last call fetches the Postgres OID for `_agtype` and configures PostgresNIO decoding.


#### Querying with SwiftAge Extensions

After that, graph querying can happen:

```swift
// with EventLoop...
let agRows = try connection.execCypher(
	"SELECT * FROM cypher('test_graph_1', $$ MATCH (v:Person) RETURN v $$) as (v agtype);", 
	logger: logger).wait()

// ...or Async/Await
let agRows = try await connection.execCypher(
	"SELECT * FROM cypher('test_graph_1', $$ MATCH (v:Person) RETURN v $$) as (v agtype);", 
	logger: logger)
```

The returned `CypherQueryResult` struct contains the `PostgresQueryMetadata` data similar to `PostgresQueryResult` but the `rows` field is an `AGValue` array. The `AGValue` type can be one of the scalar types defined by [Apache AGE](https://age.apache.org/age-manual/master/intro/types.html) as well as a struct to represent a Vertex, Edge or Path.


#### Querying with PostgresNIO Decoding

Instead of using the `execCypher()` calls, you can use the normal PostgresNIO methods for querying and fetching results. SwiftAge will return `agtype` data in a `AGValueWrapper` whose value can be cast to appropriate types:

```swift
let rows = try await connection.query(
	"SELECT * FROM cypher('test_graph_1', $$ MATCH (v:Person) RETURN v $$) as (v agtype);", 
	logger: logger)
for try await (agValue) in rows.decode((AGValueWrapper).self, context: .default) {
	if let vertex = agValue.value as? Vertex {
		print(vertex.label)
	}
}
```

#### Parameters

The `AGValueWrapper` struct can also be used to properly encode Postgres binding parameters:

```swift
let params: Dictionary<String,AGValue> = ["newName": "Little'Bobby'Tables"]
let paramsWrapper: AGValueWrapper = AGValueWrapper.init(value: params)
let agRows = try await connection.execCypher(
	"SELECT * FROM cypher('test_graph_1', $$ CREATE (v:Person {name: $newName}) RETURN v $$, \( paramsWrapper )) as (v agtype);",
	logger: logger)
```

Between PostgresNIO and SwiftAge, this will result in the query being converted to:

```sql
SELECT * FROM cypher('test_graph_1', $$ CREATE (v:Person {name: $newName}) RETURN v $$, $1) as (v agtype);
```

And the `$1` parameter being a jsonb encoding of the Dictionary.

## Getting started

See [SwiftAgeExamples](https://github.com/joshjacob/SwiftAgeExamples) for additional examples.

## Known Issues

1. No support for connections to different databases in the same runtime. Each PostgreSQL + Apache AGE installation can configure the AGE custom data type with different identifiers. While SwiftAge will find and configure the parsing for the identifier, PostgresNIO only allows that configuration at the runtime scope and not scoped per connection. If you are connecting to multiple databases, PostgresNIO Decoding will likely fail. The folowing PostgresNIO issue tracks an improvement to correct this: [https://github.com/vapor/postgres-nio/issues/333](https://github.com/vapor/postgres-nio/issues/333)
