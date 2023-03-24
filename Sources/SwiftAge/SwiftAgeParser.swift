//
//  SwiftAgeParser.swift
//  
//
//  Created by Joshua Jacob on 3/7/23.
//

import Foundation
import Antlr4
import NIO

public class SwiftAgeParser {
    
    public static let jsonBVersionBytes: [UInt8] = [0x01]
    
    public static func parse(input: String) throws -> AGValue? {
        let inputStream = ANTLRInputStream(input)
        let lexer = AgtypeLexer(inputStream)
        let tokenStream = CommonTokenStream(lexer)
        let parser = try AgtypeParser(tokenStream)
        let agType = try parser.agType()
        let visitor = SwiftAgeVisitor()
        let parsed = agType.accept(visitor)
        return parsed ?? nil
    }
    
    public static func parseByteBuffer(_ byteBuffer: inout ByteBuffer) throws -> AGValue? {
        // skip jsonb version, get json as string
        let _ = byteBuffer.readBytes(length: jsonBVersionBytes.count)
        let readableBytes = byteBuffer.readableBytes
        let data = Data((byteBuffer.readBytes(length: readableBytes)) ?? [UInt8]())
        let string = String.init(data: data, encoding: .utf8) ?? ""
        // parse string
        return try SwiftAgeParser.parse(input: string)
    }
}
