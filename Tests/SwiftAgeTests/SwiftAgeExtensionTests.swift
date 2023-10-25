import XCTest
import PostgresNIO
import NIOPosix
import Logging
import Antlr4
import NIO
@testable import SwiftAge

final class SwiftAgeExtensionTests: XCTestCase {
    
    var eventLoopGroup: MultiThreadedEventLoopGroup?
    var logger: Logger?
    var connection: PostgresConnection?
    
    // MARK: - Debug Printing
    
    let debugPrint = true
    
    func debugPrintArray(_ array: [AGValue], indent: String = "") {
        let indentSpace = "    "
        for element in array {
            if let vertex = element as? Vertex {
                print(indent + "Vertex id \(vertex.id)")
                print(indent + indentSpace + "label: \(vertex.label)")
                print(indent + indentSpace + "properties:")
                debugPrintDictionary(vertex.properties, indent: indent + indentSpace + indentSpace)
            } else if let edge = element as? Edge {
                print(indent + "Edge connection \(String(describing: edge.startId)) to \(String(describing: edge.endId))")
                print(indent + indentSpace + "label: \(edge.label)")
            } else if let path = element as? Path {
                print(indent + "Path with \(path.entities.count) values")
                debugPrintArray(path.entities, indent: indent + indentSpace)
            } else if let subArray = element as? [AGValue] {
                print(indent + "Array of:")
                debugPrintArray(subArray, indent: indent + indentSpace)
            } else {
                print(indent + "Scalar type \(type(of: element)) with value \(String(describing: element))")
            }
        }
    }
    
    func debugPrintDictionary(_ dict: Dictionary<String,AGValue>, indent: String) {
        for element in dict.keys {
            print(indent + "\(element): \(String(describing: dict[element]))")
        }
    }
    
    // MARK: - Setup and Tear Down
    
    func env(_ name: String) -> String? {
        getenv(name).flatMap { String(cString: $0) }
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        var logger = Logger(label: "postgres-logger")
        logger.logLevel = .debug
        
        let port = env("POSTGRES_PORT") ?? "5455"
        let config = PostgresConnection.Configuration(
            connection: .init(
             host: env("POSTGRES_HOSTNAME") ?? "localhost",
             port: Int(port) ?? 5455
            ),
            authentication: .init(
             username: env("POSTGRES_USER") ?? "postgresUser",
             database: env("POSTGRES_DB") ?? "postgresDB",
             password: env("POSTGRES_PASSWORD") ?? "postgresPW"
            ),
            tls: .disable
         )

        var connection: PostgresConnection? = nil
        do {
            connection = try PostgresConnection.connect(
                on: eventLoopGroup.next(),
                configuration: config,
                id: 1,
                logger: logger
            ).wait()
        } catch let error as PSQLError {
            // logger.error("\(error.debugDescription)")
            logger.error("\( String(reflecting: error) )")
        }
        
        self.eventLoopGroup = eventLoopGroup
        self.logger = logger
        self.connection = connection
    }
    
    override func tearDown() async throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        guard let eventLoopGroup = self.eventLoopGroup,
              let connection = self.connection else { return }
        
        // Close your connection once done
        let _ = try await connection.close()

        // Shutdown the EventLoopGroup, once all connections are closed.
        try await eventLoopGroup.shutdownGracefully()
    }
    
    // MARK: - Async
    
    func testQueryVertexAsync() async throws {
        guard let connection = self.connection, let logger = self.logger else { return }
        
        try await connection.setUpAge(logger: logger)
        let agRows = try await connection.execCypher("SELECT * FROM cypher('test_graph_1', $$ MATCH (v:Person) RETURN v $$) as (v agtype);", logger: logger)
        if debugPrint {
            debugPrintArray(agRows.rows)
        }
        XCTAssert(agRows.count > 0)
        XCTAssert(agRows.first is Vertex)
    }
    
    // MARK: - EventLoop
    
    func testQueryVertexEventLoop() throws {
        guard let connection = self.connection, let logger = self.logger else { return }
        
        try connection.setUpAge(logger: logger).wait()
        let agRows = try connection.execCypher("SELECT * FROM cypher('test_graph_1', $$ MATCH (v:Person) RETURN v $$) as (v agtype);", logger: logger).wait()
        if debugPrint {
            debugPrintArray(agRows.rows)
        }
        XCTAssert(agRows.count > 0)
        XCTAssert(agRows.first is Vertex)
    }
    
    func testQuery2() async throws {
        guard let connection = self.connection, let logger = self.logger else { return }
        
        XCTAssertNoThrow(try connection.setUpAge(logger: logger).wait())
        connection.execCypher("SELECT * FROM cypher('test_graph_1', $$ MATCH (v:Person) RETURN v $$) as (v agtype);", logger: logger).whenComplete {
            switch $0 {
            case .success(let result):
                if self.debugPrint {
                    self.debugPrintArray(result.rows)
                }
                XCTAssert(result.rows.count > 0)
                XCTAssert(result.rows.first is Vertex)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func testQueryPathAsync() async throws {
        guard let connection = self.connection, let logger = self.logger else { return }
        
        let query = """
            SELECT * from cypher('test_graph_1', $$
                    MATCH (V)-[R:RELTYPE]-(V2)
                    RETURN [V,R,V2]::path as p
            $$) as (p agtype);
        """
        
        try await connection.setUpAge(logger: logger)
        let agRows = try await connection.execCypher(PostgresQuery.init(stringLiteral: query), logger: logger)
        if debugPrint {
            debugPrintArray(agRows.rows)
        }
        XCTAssert(agRows.count > 0)
        if let row = agRows.first,
           let path = row as? Path{
            XCTAssert(path.entities[0] is Vertex)
            XCTAssert(path.entities[1] is Edge)
            XCTAssert(path.entities[2] is Vertex)
        } else {
            XCTFail()
        }
    //        XCTAssert((agRows.first as! [AGValue])[0] is Vertex)
    //        XCTAssert((agRows.first as! [AGValue])[1] is Edge)
    //        XCTAssert((agRows.first as! [AGValue])[2] is Vertex)

    }
    
    // MARK: - PostgresNIO Row Decoding
    
    func testQueryDecodeRowAsync() async throws {
        guard let connection = self.connection, let logger = self.logger else { return }
        try await connection.setUpAge(logger: logger)
        
        let rows = try await connection.query(
            "SELECT * FROM cypher('test_graph_1', $$ MATCH (v:Person) RETURN v $$) as (v agtype);",
            logger: logger)
        for try await (agValue) in rows.decode((AGValueWrapper).self, context: .default) {
            if debugPrint {
                print(agValue.value as Any)
            }
        }
    }
    
    func testQueryDecodeRowEventLoop() throws {
        guard let connection = self.connection, let logger = self.logger else { return }
        try connection.setUpAge(logger: logger).wait()
        
        let result = try connection.query(
            "SELECT * FROM cypher('test_graph_1', $$ MATCH (v:Person) RETURN v $$) as (v agtype);",
            logger: logger).wait()
        for row in result.rows {
            let (agValue) = try row.decode((AGValueWrapper).self)
            if debugPrint {
                print(agValue.value as Any)
            }
        }
    }
    
    // MARK: - Parameters
    
    func testParamsAsync() async throws {
        guard let connection = self.connection, let logger = self.logger else { return }
        try await connection.setUpAge(logger: logger)
        
        // set params
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let testName = dateFormatter.string(from: Date())
        var params: Dictionary<String,AGValue> = ["name": testName]
        var paramsWrapper: AGValueWrapper = AGValueWrapper.init(value: params)
        
        // create
        var agRows = try await connection.execCypher(
                "SELECT * FROM cypher('test_graph_1', $$ CREATE (v:Person {name: $name}) RETURN v $$, \( paramsWrapper )) as (v agtype);",
                logger: logger)
        if debugPrint { debugPrintArray(agRows.rows) }
        if let row = agRows.first,
            let vertex = row as? Vertex,
            let name = vertex.properties["name"] as? String {
            XCTAssert(name == testName)
        } else {
            XCTFail()
        }
        
        // read
        agRows = try await connection.execCypher(
                "SELECT * FROM cypher('test_graph_1', $$ MATCH (v:Person {name: $name}) RETURN v $$, \( paramsWrapper )) as (v agtype);",
                logger: logger)
        if debugPrint { debugPrintArray(agRows.rows) }
        if let row = agRows.first,
            let vertex = row as? Vertex,
            let name = vertex.properties["name"] as? String {
            XCTAssert(name == testName)
        } else {
            XCTFail()
        }
        
        // update
        let testNewName = "\(testName)-updated"
        params["newName"] = testNewName
        paramsWrapper = AGValueWrapper.init(value: params)
        agRows = try await connection.execCypher(
                "SELECT * FROM cypher('test_graph_1', $$ MATCH (v:Person {name: $name}) SET v.name = $newName RETURN v $$, \( paramsWrapper )) as (v agtype);",
                logger: logger)
        if debugPrint { debugPrintArray(agRows.rows) }
        if let row = agRows.first,
            let vertex = row as? Vertex,
            let name = vertex.properties["name"] as? String {
            XCTAssert(name == testNewName)
        } else {
            XCTFail()
        }
        
        // delete
        agRows = try await connection.execCypher(
                "SELECT * FROM cypher('test_graph_1', $$ MATCH (v:Person {name: $newName}) DELETE v $$, \( paramsWrapper )) as (v agtype);",
                logger: logger)
        agRows = try await connection.execCypher(
                "SELECT * FROM cypher('test_graph_1', $$ MATCH (v:Person {name: $newName}) RETURN v $$, \( paramsWrapper )) as (v agtype);",
                logger: logger)
        if debugPrint { debugPrintArray(agRows.rows) }
        XCTAssert(agRows.rows.count == 0)
    }
    
    func testParamsEventLoop() throws {
        guard let connection = self.connection, let logger = self.logger else { return }
        try connection.setUpAge(logger: logger).wait()
        
        // set params
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let testName = dateFormatter.string(from: Date())
        var params: Dictionary<String,AGValue> = ["name": testName]
        var paramsWrapper: AGValueWrapper = AGValueWrapper.init(value: params)
        
        // create
        var agRows = try connection.execCypher(
                "SELECT * FROM cypher('test_graph_1', $$ CREATE (v:Person {name: $name}) RETURN v $$, \( paramsWrapper )) as (v agtype);",
                logger: logger).wait()
        if debugPrint { debugPrintArray(agRows.rows) }
        if let row = agRows.first,
            let vertex = row as? Vertex,
            let name = vertex.properties["name"] as? String {
            XCTAssert(name == testName)
        } else {
            XCTFail()
        }
        
        // read
        agRows = try connection.execCypher(
                "SELECT * FROM cypher('test_graph_1', $$ MATCH (v:Person {name: $name}) RETURN v $$, \( paramsWrapper )) as (v agtype);",
                logger: logger).wait()
        if debugPrint { debugPrintArray(agRows.rows) }
        if let row = agRows.first,
            let vertex = row as? Vertex,
            let name = vertex.properties["name"] as? String {
            XCTAssert(name == testName)
        } else {
            XCTFail()
        }
        
        // update
        let testNewName = "\(testName)-updated"
        params["newName"] = testNewName
        paramsWrapper = AGValueWrapper.init(value: params)
        agRows = try connection.execCypher(
                "SELECT * FROM cypher('test_graph_1', $$ MATCH (v:Person {name: $name}) SET v.name = $newName RETURN v $$, \( paramsWrapper )) as (v agtype);",
                logger: logger).wait()
        if debugPrint { debugPrintArray(agRows.rows) }
        if let row = agRows.first,
            let vertex = row as? Vertex,
            let name = vertex.properties["name"] as? String {
            XCTAssert(name == testNewName)
        } else {
            XCTFail()
        }
        
        // delete
        agRows = try connection.execCypher(
                "SELECT * FROM cypher('test_graph_1', $$ MATCH (v:Person {name: $newName}) DELETE v $$, \( paramsWrapper )) as (v agtype);",
                logger: logger).wait()
        agRows = try connection.execCypher(
                "SELECT * FROM cypher('test_graph_1', $$ MATCH (v:Person {name: $newName}) RETURN v $$, \( paramsWrapper )) as (v agtype);",
                logger: logger).wait()
        if debugPrint { debugPrintArray(agRows.rows) }
        XCTAssert(agRows.rows.count == 0)
    }
}
