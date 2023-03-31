import Foundation
import PostgresNIO
import NIO

// TODO: Use AGValue directly
public struct AGValueWrapper: AGValue {
    var value: AGValue?
    
    public init(value: AGValue? = nil) {
        self.value = value
    }
}

extension AGValueWrapper: PostgresEncodable {
    public static var psqlFormat: PostgresFormat {
        .binary
    }
    
    public static var psqlType: PostgresDataType = PostgresDataType(16448)
    
    public func encode<JSONEncoder>(into byteBuffer: inout ByteBuffer, context: PostgresEncodingContext<JSONEncoder>) throws where JSONEncoder : PostgresJSONEncoder {
        byteBuffer.writeBytes(SwiftAgeParser.jsonBVersionBytes)
        let jsonData = try JSONSerialization.data(withJSONObject: self.value as Any, options: [])
        let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!
        byteBuffer.writeString(jsonString)
        
        // TODO: Get AGValue types to conform to Encodable
        // byteBuffer.writeData(try context.jsonEncoder.encode(self.value))
    }
}

extension AGValueWrapper: PostgresDecodable {
    public init<JSONDecoder>(from byteBuffer: inout ByteBuffer, type: PostgresDataType, format: PostgresFormat, context: PostgresDecodingContext<JSONDecoder>) throws where JSONDecoder : PostgresJSONDecoder {
        guard type == AGValueWrapper.psqlType else { return }
        self.value = try SwiftAgeParser.parseByteBuffer(&byteBuffer) //' SwiftAgeParser.parse(input: string)
    }
}

public struct CypherQueryResult {
    public let metadata: PostgresQueryMetadata
    public let rows: [AGValue]
}

extension CypherQueryResult: Collection {
    public typealias Index = Int
    public typealias Element = AGValue

    public var startIndex: Int {
        self.rows.startIndex
    }

    public var endIndex: Int {
        self.rows.endIndex
    }

    public subscript(position: Int) -> AGValue {
        self.rows[position]
    }

    public func index(after i: Int) -> Int {
        self.rows.index(after: i)
    }
}

extension PostgresConnection {
    
    public func setUpAge(logger: Logger) -> EventLoopFuture<Void> {
        return self.query("LOAD 'age';", logger: logger).flatMap { _ in
            return self.query("SET search_path = ag_catalog, \"$user\", public;", logger: logger).flatMap { _ in
                return self.query("SELECT cast(typelem as INTEGER) FROM pg_type WHERE typname='_agtype'", logger: logger).flatMapResult { body in
                    return Result {
                        if let row = body.rows.first,
                           let ageId = try row.first?.decode(Int32.self) {
                            print("Apache AGE installed with _agtype oid = \(ageId)")
                            AGValueWrapper.psqlType = PostgresDataType(UInt32(ageId))
                        }
                        // TODO: exception where AGE isn't installed
                        return Void()
                    }
                }
            }
        }
    }
    
    public func setUpAge(logger: Logger) async throws {
        let _ = try await self.query("LOAD 'age';", logger: logger).get()
        let _ = try await self.query("SET search_path = ag_catalog, \"$user\", public;", logger: logger).get()
        let result = try await self.query("SELECT cast(typelem as INTEGER) FROM pg_type WHERE typname='_agtype'", logger: logger).get()
        if let row = result.rows.first,
            let ageId = try row.first?.decode(Int32.self) {
            print("Apache AGE installed with _agtype oid = \(ageId)")
            AGValueWrapper.psqlType = PostgresDataType(UInt32(ageId))
        }
        // TODO: exception where AGE isn't installed
    }
    
    public func execCypher(
         _ query: PostgresQuery,
         logger: Logger,
         file: String = #file,
         line: Int = #line
    ) -> EventLoopFuture<CypherQueryResult> {
        self.query(query, logger: logger, file: file, line: line).flatMapThrowing { result in
            let agRows = try self.parseRows(result)
            return CypherQueryResult(metadata: result.metadata, rows: agRows)
        }
    }
     
//     func execCypher(
//         _ query: PostgresQuery,
//         logger: Logger,
//         file: String = #file,
//         line: Int = #line,
//         _ onRow: @escaping (PostgresRow) throws -> ()
//     ) -> EventLoopFuture<PostgresQueryMetadata> {
//
//     }
     
     public func execCypher(
         _ query: PostgresQuery,
         logger: Logger,
         file: String = #file,
         line: Int = #line
     ) async throws -> CypherQueryResult {
         let result = try await self.query(query, logger: logger, file: file, line: line).get()
         let agRows = try self.parseRows(result)
         return CypherQueryResult(metadata: result.metadata, rows: agRows)
     }
    
    private func parseRows(_ rows: PostgresQueryResult) throws -> Array<AGValue> {
        var agRows = Array<AGValue>()
        
        for row in rows {
            if (row.count > 1) {
                var agCells = Array<AGValue>()
                for cell in row {
                    if let parsed = try parseCell(cell) {
                        agCells.append(parsed)
                    }
                }
                // TODO: Add vertex/edge elements to a path
                agRows.append(agCells)
            } else {
                if let cell = row.first {
                    if let parsed = try parseCell(cell) {
                        agRows.append(parsed)
                    }
                }
            }
        }
        
        return agRows
    }
    
    private func parseCell(_ cell: PostgresCell) throws -> AGValue? {
        let byteBuffer = cell.bytes
        if var byteBuffer = byteBuffer {
            return try SwiftAgeParser.parseByteBuffer(&byteBuffer)
        } else {
            return nil
        }
    }
}
