import XCTest
import PostgresNIO
import NIOPosix
import Logging
import Antlr4
import NIO
@testable import SwiftAge

final class SwiftAgeExtensionTests: XCTestCase {
    
    // let connectionHost = "localhost"
    let connectionHost = "192.168.3.170"
    let connectionPort = 5455
    let authenticationUsername = "postgresUser"
    let authenticationDatabase = "postgresDB"
    let authenticationPassword = "postgresPW"
    
    var eventLoopGroup: MultiThreadedEventLoopGroup?
    var logger: Logger?
    var connection: PostgresConnection?
    
    let debugPrint = true
    
    func debugPrintArray(_ array: [AGValue], indent: String = "") {
        let indentSpace = "    "
        for element in array {
            if let vertex = element as? Vertex {
                print(indent + "Vertex id \(vertex.id)")
                print(indent + indentSpace + "label: \(vertex.label)")
                print(indent + indentSpace + "properties:")
                if let dict = vertex.properties as? Dictionary<String,AGValue> {
                    debugPrintDictionary(dict, indent: indent + indentSpace + indentSpace)
                }
            } else if let edge = element as? Edge {
                print(indent + "Edge connection \(String(describing: edge.startId)) to \(String(describing: edge.endId))")
                print(indent + indentSpace + "label: \(edge.label)")
            } else if let path = element as? Path {
                print(indent + "Path with \(path.entities.count) values")
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
    
    override func setUp() async throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let eventLoopGroup = MultiThreadedEventLoopGroup(numberOfThreads: 1)
        let logger = Logger(label: "postgres-logger")
        
        let config = PostgresConnection.Configuration(
           connection: .init(
            host: self.connectionHost,
            port: self.connectionPort
           ),
           authentication: .init(
            username: self.authenticationUsername,
            database: self.authenticationDatabase,
            password: self.authenticationPassword
           ),
           tls: .disable
        )

        let connection = try await PostgresConnection.connect(
          on: eventLoopGroup.next(),
          configuration: config,
          id: 1,
          logger: logger
        ).get()
        
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
        try eventLoopGroup.syncShutdownGracefully()
    }
    
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
    
    func testQueryVertexEventLoop() throws {
        guard let connection = self.connection, let logger = self.logger else { return }
        
        let _ = try connection.setUpAge(logger: logger).wait()
        let agRows = try connection.execCypher("SELECT * FROM cypher('test_graph_1', $$ MATCH (v:Person) RETURN v $$) as (v agtype);", logger: logger).wait()
        if debugPrint {
            debugPrintArray(agRows.rows)
        }
        XCTAssert(agRows.count > 0)
        XCTAssert(agRows.first is Vertex)
    }
    
    func testQuery2() async throws {
        guard let connection = self.connection, let logger = self.logger else { return }
        
        try await connection.setUpAge(logger: logger)
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
                    RETURN V,R,V2
            $$) as (V agtype, R agtype, V2 agtype);
        """
        
        try await connection.setUpAge(logger: logger)
        let agRows = try await connection.execCypher(PostgresQuery.init(stringLiteral: query), logger: logger)
        if debugPrint {
            debugPrintArray(agRows.rows)
        }
        XCTAssert(agRows.count > 0)
        XCTAssert((agRows.first as! [AGValue])[0] is Vertex)
        XCTAssert((agRows.first as! [AGValue])[1] is Edge)
        XCTAssert((agRows.first as! [AGValue])[2] is Vertex)
    }
    
    func testQuery3() async throws {
        guard let connection = self.connection, let logger = self.logger else { return }
        
        try await connection.setUpAge(logger: logger)
        let agRows = try await connection.query("SELECT count(*) FROM ag_graph WHERE name='test_graph_1';", logger: logger).collect()
        print(agRows.first as Any)
    }
}
