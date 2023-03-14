import Foundation
import PostgresNIO
import NIO

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
    
    public func setUpAge(logger: Logger) throws -> EventLoopFuture<PostgresQueryResult> {
        return self.query("LOAD 'age';", logger: logger).flatMap { _ in
            return self.query("SET search_path = ag_catalog, \"$user\", public;", logger: logger)
        }
    }
    
    public func setUpAge(logger: Logger) async throws {
        let _ = try await self.query("LOAD 'age';", logger: logger).get()
        let _ = try await self.query("SET search_path = ag_catalog, \"$user\", public;", logger: logger).get()
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
        var byteBuffer = cell.bytes
        // skip jsonb version, get json as string
        let jsonBVersionBytes: [UInt8] = [0x01]
        let _ = byteBuffer?.readBytes(length: jsonBVersionBytes.count)
        let readableBytes = byteBuffer?.readableBytes ?? 0
        let data = Data((byteBuffer?.readBytes(length: readableBytes)) ?? [UInt8]())
        let string = String.init(data: data, encoding: .utf8) ?? ""
        // parse string
        return try SwiftAgeParser.parse(input: string)
    }
}
