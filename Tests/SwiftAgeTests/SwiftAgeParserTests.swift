import XCTest
@testable import SwiftAge

#if os(Linux)
// swiftlint:disable:next identifier_name
private let NSEC_PER_SEC = 1_000_000_000
#endif

final class SwiftAgeParserTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testNormalValueParsing() throws {
        let strStr = "\"abcd\""
        let strValue = try SwiftAgeParser.parse(input: strStr)
        XCTAssert(strValue as? String == "abcd")
        
        let intStr = "1234"
        let intValue = try SwiftAgeParser.parse(input: intStr)
        XCTAssert(intValue as? Int64 == 1234)
        
        let intStr2 = "-1234"
        let intValue2 = try SwiftAgeParser.parse(input: intStr2)
        XCTAssert(intValue2 as? Int64 == -1234)
        
        let floatStr = "1234.56789"
        let floatValue = try SwiftAgeParser.parse(input: floatStr)
        XCTAssert(floatValue as? Double == 1234.56789)
        
        let floatStr2 = "6.45161290322581e+46"
        let floatValue2 = try SwiftAgeParser.parse(input: floatStr2)
        XCTAssert(floatValue2 as? Double == 6.45161290322581e+46)
        
        let float3Str = "-1234.56789"
        let float3Value = try SwiftAgeParser.parse(input: float3Str)
        XCTAssert(float3Value as? Double == -1234.56789)
        
        let boolTrueStr = "true"
        let boolTrueValue = try SwiftAgeParser.parse(input: boolTrueStr)
        XCTAssert(boolTrueValue as? Bool == true)
        
        let boolFalseStr = "false"
        let boolFalseValue = try SwiftAgeParser.parse(input: boolFalseStr)
        XCTAssert(boolFalseValue as? Bool == false)
        
        let nullStr = "null"
        let nullValue = try SwiftAgeParser.parse(input: nullStr)
        XCTAssert(nullValue == nil)
        
        let nanStr = "NaN"
        let nanValue = try SwiftAgeParser.parse(input: nanStr)
        if let nanFloat = nanValue as? Double {
            XCTAssert(nanFloat.isNaN)
        } else {
            XCTFail()
        }
        
        let infinityStr = "Infinity"
        let infinityValue = try SwiftAgeParser.parse(input: infinityStr)
        if let infinityFloat = infinityValue as? Double {
            XCTAssert(infinityFloat.isInfinite)
        } else {
            XCTFail()
        }
        
        let negInfinityStr = "-Infinity"
        let negInfinityValue = try SwiftAgeParser.parse(input: negInfinityStr)
        if let negInfinityFloat = negInfinityValue as? Double {
            XCTAssert(negInfinityFloat.isInfinite)
        } else {
            XCTFail()
        }
        
        // TODO: Confirm expectation of Decimal from Age
        let numericStr1 = "12345678901234567890123456.789::numeric"
        let numericValue1 = try SwiftAgeParser.parse(input: numericStr1)
        XCTAssert(numericValue1 as? Decimal == Decimal.init(string: "12345678901234567890123456.789"))
        
        // TODO: Confirm expectation of Decimal from Age
        let numericStr2 = "12345678901234567890123456::numeric"
        let numericValue2 = try SwiftAgeParser.parse(input: numericStr2)
        XCTAssert(numericValue2 as? Decimal == Decimal.init(string: "12345678901234567890123456"))
        
        let mapStr = """
{"name": "Smith", "num":123, "yn":true, "bigInt":123456789123456789123456789123456789::numeric}
"""
        let mapValue = try SwiftAgeParser.parse(input: mapStr)
        if let mapDict = mapValue as? Dictionary<String,AGValue> {
            
            XCTAssert((mapDict["name"] as? String) == "Smith")
            XCTAssert((mapDict["num"] as? Int64) == 123)
            XCTAssert((mapDict["yn"] as? Bool) == true)
            XCTAssert((mapDict["bigInt"] as? Decimal) == Decimal.init(string: "123456789123456789123456789123456789"))
            
        } else {
            XCTFail()
        }
        
        let arrStr = """
["name", "Smith", "num", 123, "yn", true, 123456789123456789123456789123456789.8888::numeric]
"""
        let arrValue = try SwiftAgeParser.parse(input: arrStr)
        if let arrArr = arrValue as? Array<AGValue> {
            
            XCTAssert((arrArr[0] as? String) == "name")
            XCTAssert((arrArr[1] as? String) == "Smith")
            XCTAssert((arrArr[2] as? String) == "num")
            XCTAssert((arrArr[3] as? Int64) == 123)
            XCTAssert((arrArr[4] as? String) == "yn")
            XCTAssert((arrArr[5] as? Bool) == true)
            XCTAssert((arrArr[6] as? Decimal) == Decimal.init(string: "123456789123456789123456789123456789.8888"))
            
        } else {
            XCTFail()
        }
        
    }
    
    func testVertexParsing() throws {
     
        let vertexExp = """
{"id": 2251799813685425, "label": "Person",
"properties": {"name": "Smith", "numInt":123, "numFloat": 384.23424,
"bigInt":123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789::numeric,
"bigFloat":123456789123456789123456789123456789.12345::numeric,
"yn":true, "nullVal": null}}::vertex
"""
        let vertexValue = try SwiftAgeParser.parse(input: vertexExp)
        if let vertex = vertexValue as? Vertex {
            
            XCTAssert(vertex.id == 2251799813685425)
            XCTAssert(vertex.label == "Person")
            XCTAssert(vertex.properties["name"] as? String == "Smith")
            XCTAssert(vertex.properties["numInt"] as? Int64 == 123)
            XCTAssert(vertex.properties["numFloat"] as? Double == 384.23424)
            XCTAssert(vertex.properties["bigInt"] as? Decimal ==
             Decimal.init(string: "123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789123456789"))
            XCTAssert(vertex.properties["bigFloat"] as? Decimal ==
             Decimal.init(string: "123456789123456789123456789123456789.12345"))
            XCTAssert(vertex.properties["yn"] as? Bool == true)
            XCTAssert(vertex.properties["nullVal"] as? NSNull == nil)
            
        } else {
            XCTFail()
        }
        
    }
    
    func testPathParsing() throws {
        let pathExp = """
[{"id": 2251799813685425, "label": "Person", "properties": {"name": "Smith"}}::vertex,
{"id": 2533274790396576, "label": "workWith", "end_id": 2251799813685425, "start_id": 2251799813685424,
"properties": {"weight": 3, "bigFloat":123456789123456789123456789.12345::numeric}}::edge,
{"id": 2251799813685424, "label": "Person", "properties": {"name": "Joe"}}::vertex]::path
"""
        let pathValue = try SwiftAgeParser.parse(input: pathExp)
        if let path = pathValue as? Path,
           let vertex1 = path.entities[0] as? Vertex,
           let edge = path.entities[1] as? Edge,
           let vertex2 = path.entities[2] as? Vertex {
            
            XCTAssert(vertex1.id == 2251799813685425)
            XCTAssert(vertex1.label == "Person")
            XCTAssert(vertex1.properties["name"] as? String == "Smith")
            XCTAssert(edge.id == 2533274790396576)
            XCTAssert(edge.label == "workWith")
            XCTAssert(edge.endId == 2251799813685425)
            XCTAssert(edge.startId == 2251799813685424)
            XCTAssert(edge.properties["weight"] as? Int64 == 3)
            XCTAssert(edge.properties["bigFloat"] as? Decimal == Decimal.init(string: "123456789123456789123456789.12345"))
            XCTAssert(vertex2.id == 2251799813685424)
            XCTAssert(vertex2.label == "Person")
            XCTAssert(vertex2.properties["name"] as? String == "Joe")
            
        } else {
            XCTFail()
        }
    }
}
