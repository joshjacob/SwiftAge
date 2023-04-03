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
    public var entities: [AGValue] = [AGValue]()
    
    init(entities: [AGValue]) {
        self.entities = entities
    }
}

public struct Vertex : AGValue, AGObj {
    public var id : Int64
    public var label : String
    public var properties : Dictionary<String,AGValue>
    
    init(id: Int64, label: String, properties: Dictionary<String,AGValue>) {
        self.id = id
        self.label = label
        self.properties = properties
    }
}

public struct Edge : AGValue, AGObj {
    public var id : Int64
    public var label : String
    public var startId : Int64? = nil
    public var endId : Int64? = nil
    public var properties : Dictionary<String,AGValue>
    
    init(id: Int64, label: String, properties: Dictionary<String,AGValue>) {
        self.id = id
        self.label = label
        self.properties = properties
    }
}
