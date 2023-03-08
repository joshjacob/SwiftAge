//
//  SwiftAgeModels.swift
//  
//
//  Created by Joshua Jacob on 3/7/23.
//

import Foundation
import Antlr4

public protocol AGValue { }

extension String : AGValue { }
extension Int64 : AGValue { }
extension Double : AGValue { }
extension Bool : AGValue { }
extension NSNull : AGValue { }
extension Decimal : AGValue { }
extension Dictionary : AGValue { }
extension Array : AGValue { }

public protocol AGObj { }

public struct Path : AGValue, AGObj {
    var entities: [AGValue] = [AGValue]()
    
    init(entities: [AGValue]) {
        self.entities = entities
    }
}

public struct Vertex : AGValue, AGObj {
    var id : Int64
    var label : String
    var properties : AGValue
    
    init(id: Int64, label: String, properties: AGValue) {
        self.id = id
        self.label = label
        self.properties = properties
    }
}

public struct Edge : AGValue, AGObj {
    var id : Int64
    var label : String
    var startId : Int64? = nil
    var endId : Int64? = nil
    var properties : AGValue
    
    init(id: Int64, label: String, properties: AGValue) {
        self.id = id
        self.label = label
        self.properties = properties
    }
}
