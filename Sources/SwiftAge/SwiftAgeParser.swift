//
//  SwiftAgeParser.swift
//  
//
//  Created by Joshua Jacob on 3/7/23.
//

import Foundation
import Antlr4

public class SwiftAgeParser {
    
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
}
